import Ising2DLambda.KacWard.SuccessorDirectionSelection
import Ising2DLambda.KacWard.CyclicTurningVanishes
import Ising2DLambda.NecSuf.KacWard.StepAdvancesDirection

namespace Ising2DLambda.KacWard

/-- 実際の二辺の方向番号で定める一歩の整数回転数。
後続辺でない組への値は全域化のための零である。 -/
def stepTurning {L : ℕ} (e f : OrientedEdge L) : ℤ :=
  if f ∈ nonbacktrackingSuccessors e then
    if directionNumber f = directionNumber e then 0
    else if directionNumber f = directionNumber e + 1 then 1
    else if directionNumber f = directionNumber e - 1 then -1
    else 0
  else 0

/-- `claim_step_advances_direction` for actual nonbacktracking edges. -/
theorem step_advances_direction {L : ℕ} [NeZero L]
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    directionNumber f = directionNumber e + directionResidueProjection (stepTurning e f) := by
  have hreverse : directionNumber f ≠ directionNumber e + 2 := by
    intro h
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (h.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  have htable : ∀ a b : ZMod 4,
      b = a ∨ b = a + 1 ∨ b = a - 1 ∨ b = a + 2 := by decide
  have hcases := htable (directionNumber e) (directionNumber f)
  rcases hcases with h | h | h | h
  · simp [stepTurning, hf, directionResidueProjection, h]
  · simp [stepTurning, hf, directionResidueProjection, h]
  · simp [stepTurning, hf, directionResidueProjection, h, sub_eq_add_neg] <;> decide
  · exact (hreverse h).elim

/-- Reversing the order and orientation of a nonbacktracking pair negates its turn. -/
theorem stepTurning_reversed_pair {L : ℕ} [NeZero L] (e f : OrientedEdge L)
    (hf : f ∈ nonbacktrackingSuccessors e) :
    stepTurning (reversal f) (reversal e) = -stepTurning e f := by
  have hrev : reversal e ∈ nonbacktrackingSuccessors (reversal f) := by
    apply Finset.mem_filter.mpr
    have hs := (Finset.mem_filter.mp hf).2.1
    refine ⟨Finset.mem_univ _, ?_, ?_⟩
    · rw [orientedTarget_reversal]
      have hr : orientedSource (reversal e) = orientedTarget e := by
        rcases e with ⟨edge, false | true⟩ <;> rfl
      exact hs.symm.trans hr.symm
    · intro heq
      apply (Finset.mem_filter.mp hf).2.2
      simpa only [reversal_involutive] using heq.symm
  have hreverse : directionNumber f ≠ directionNumber e + 2 := by
    intro h
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (h.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  simp only [stepTurning, if_pos hf, if_pos hrev]
  rw [directionNumber_reversal, directionNumber_reversal]
  generalize ha : directionNumber e = a at *
  generalize hb : directionNumber f = b at *
  fin_cases a <;> fin_cases b <;> simp_all <;> decide

end Ising2DLambda.KacWard
