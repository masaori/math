/-
人手証明 `claim_critical_point_rational_partition_interval` の具体版。

候補集合を有限集合 `{j ≤ N | j/N ≤_R x_c}` として作り、その最大元を取る。
住処: N, Q, Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.CriticalPointPositive
import Ising2DLambda.CriticalExponent.CriticalPointLtOne

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

noncomputable def rationalPartitionPoint
    (data : RealClosedSubfieldData) (k N : ℕ) : data.carrier :=
  ⟨algebraMap ℚ Qbar ((k : ℚ) / (N : ℚ)),
    rational_mem_realClosedCarrier data ((k : ℚ) / (N : ℚ))⟩

theorem rationalPartitionPoint_zero (data : RealClosedSubfieldData) (N : ℕ) :
    rationalPartitionPoint data 0 N = 0 := by
  apply Subtype.ext
  simp [rationalPartitionPoint]

theorem rationalPartitionPoint_top (data : RealClosedSubfieldData) (N : ℕ) (hN : 1 ≤ N) :
    rationalPartitionPoint data N N = 1 := by
  apply Subtype.ext
  simp [rationalPartitionPoint, Nat.ne_of_gt hN]

/-- 臨界点は隣り合う有理等分点に挟まれる。 -/
theorem criticalPoint_rationalPartitionInterval
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (N : ℕ) (hN : 1 ≤ N) :
    ∃ k : ℕ,
      k + 1 ≤ N ∧
      realAlgebraicLe data.toRealClosedSubfieldData
        (rationalPartitionPoint data.toRealClosedSubfieldData k N)
        (criticalPointRealClosed data.toRealClosedSubfieldData s hs) ∧
      realAlgebraicLt data.toRealClosedSubfieldData
        (criticalPointRealClosed data.toRealClosedSubfieldData s hs)
        (rationalPartitionPoint data.toRealClosedSubfieldData (k + 1) N) := by
  classical
  let base := data.toRealClosedSubfieldData
  let xc := criticalPointRealClosed base s hs
  let candidates :=
    (Finset.range (N + 1)).filter (fun j =>
      realAlgebraicLe base (rationalPartitionPoint base j N) xc)
  have hCandidates : candidates.Nonempty := by
    refine ⟨0, ?_⟩
    rw [Finset.mem_filter, Finset.mem_range]
    refine ⟨by omega, Or.inl ?_⟩
    rw [rationalPartitionPoint_zero]
    exact criticalPoint_positive data hs
  let k := candidates.max' hCandidates
  have hkMem : k ∈ candidates := Finset.max'_mem candidates hCandidates
  have hkBound : k ≤ N := by
    have hkRange : k < N + 1 := Finset.mem_range.mp (Finset.mem_filter.mp hkMem).1
    omega
  have hNNotMem : N ∉ candidates := by
    intro hMem
    have hTopLe : realAlgebraicLe base (rationalPartitionPoint base N N) xc :=
      (Finset.mem_filter.mp hMem).2
    rw [rationalPartitionPoint_top base N hN] at hTopLe
    have hUpper : realAlgebraicLt base xc 1 := criticalPoint_lt_one data hs
    rcases hTopLe with hReverse | hEqual
    · exact (realAlgebraicLt_trichotomy base xc 1).2.2.1 ⟨hUpper, hReverse⟩
    · exact (realAlgebraicLt_trichotomy base xc 1).2.1 ⟨hUpper, hEqual.symm⟩
  have hkSuccBound : k + 1 ≤ N := by
    have hkNeN : k ≠ N := by
      intro hkN
      apply hNNotMem
      simpa [hkN] using hkMem
    omega
  refine ⟨k, hkSuccBound, (Finset.mem_filter.mp hkMem).2, ?_⟩
  by_contra hNotLt
  have hNextLe : realAlgebraicLe base (rationalPartitionPoint base (k + 1) N) xc := by
    rcases (realAlgebraicLt_trichotomy base xc (rationalPartitionPoint base (k + 1) N)).1 with
      hForward | hEqual | hReverse
    · exact False.elim (hNotLt hForward)
    · exact Or.inr hEqual.symm
    · exact Or.inl hReverse
  have hNextMem : k + 1 ∈ candidates := by
    rw [Finset.mem_filter, Finset.mem_range]
    exact ⟨by omega, hNextLe⟩
  have hMax := Finset.le_max' candidates (k + 1) hNextMem
  omega

end Ising2DLambda.CriticalExponent
