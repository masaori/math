/-
`claim_critical_point_rational_partition_interval` の必要十分版。

有限列の両端が点 x を挟み、任意の二点について三分法が成り立てば、
「x 以下である番号」の最大元とその次の番号が x を挟む。
値の型には順序構造も代数構造も要求しない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield

namespace Ising2DLambda.NecSuf.CriticalExponent

open Ising2DLambda.FisherZero

theorem criticalPoint_rationalPartitionInterval_necSuf
    {A : Type*} [DecidableEq A]
    (lt : A → A → Prop) [DecidableRel lt]
    (point : ℕ → A) (x : A) (N : ℕ)
    (trichotomy : ∀ a b : A, ExactlyOneOfThree (lt a b) (a = b) (lt b a))
    (hLower : lt (point 0) x) (hUpper : lt x (point N)) :
    ∃ k : ℕ,
      k + 1 ≤ N ∧
      (lt (point k) x ∨ point k = x) ∧
      lt x (point (k + 1)) := by
  let candidates :=
    (Finset.range (N + 1)).filter (fun j => lt (point j) x ∨ point j = x)
  have hCandidates : candidates.Nonempty := by
    refine ⟨0, ?_⟩
    simp [candidates, hLower]
  let k := candidates.max' hCandidates
  have hkMem : k ∈ candidates := Finset.max'_mem candidates hCandidates
  have hkBound : k ≤ N := by
    have hkRange : k < N + 1 := Finset.mem_range.mp (Finset.mem_filter.mp hkMem).1
    omega
  have hNNotMem : N ∉ candidates := by
    intro hMem
    have hTopLe : lt (point N) x ∨ point N = x := (Finset.mem_filter.mp hMem).2
    rcases hTopLe with hReverse | hEqual
    · exact (trichotomy x (point N)).2.2.1 ⟨hUpper, hReverse⟩
    · exact (trichotomy x (point N)).2.1 ⟨hUpper, hEqual.symm⟩
  have hkSuccBound : k + 1 ≤ N := by
    have hkNeN : k ≠ N := by
      intro hkN
      apply hNNotMem
      simpa [hkN] using hkMem
    omega
  refine ⟨k, hkSuccBound, (Finset.mem_filter.mp hkMem).2, ?_⟩
  by_contra hNotLt
  have hNextLe : lt (point (k + 1)) x ∨ point (k + 1) = x := by
    rcases (trichotomy x (point (k + 1))).1 with hForward | hEqual | hReverse
    · exact False.elim (hNotLt hForward)
    · exact Or.inr hEqual.symm
    · exact Or.inl hReverse
  have hNextMem : k + 1 ∈ candidates := by
    rw [Finset.mem_filter, Finset.mem_range]
    exact ⟨by omega, hNextLe⟩
  have hMax := Finset.le_max' candidates (k + 1) hNextMem
  omega

end Ising2DLambda.NecSuf.CriticalExponent
