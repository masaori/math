/-
具体版が必要十分版の特殊化として得られることの明示。

具体版の配位を方向 1 の一周へ制限し、値を整数へ射影する。全周期辺が破れているという
仮定から一周の隣接値がすべて異なることを具体版で示し、その後の積の鎖は必要十分版へ渡す。

住処: `Fin`、`Nat`、整数 ±1、有限集合・有限積のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OddPeriodicCycle

namespace Ising3DCut.NullModel

/-- `claim_periodic_no_all_broken` の具体版を必要十分版から導いたもの。 -/
theorem periodicMultiplicity_full_eq_zero_from_necSuf {L : ℕ} (hodd : Odd L) :
    periodicMultiplicity L (Fintype.card (PeriodicEdge L)) = 0 := by
  rw [periodicMultiplicity, Fintype.card_eq_zero_iff]
  refine ⟨fun x => ?_⟩
  have hall := (Finset.mem_filter.mp x.2).2
  have hpos : 0 < L := Nat.pos_of_ne_zero (by
    intro hzero
    subst L
    exact Nat.not_odd_zero hodd)
  apply NecSuf.NullModel.no_odd_cycle_all_opposite hodd
      (fun k => (x.1 (cycleSite hpos k)).1)
  · intro k
    exact (x.1 (cycleSite hpos k)).2
  · intro k hvalue
    apply cycle_values_opposite_of_all_broken hpos x.1 hall k
    apply Subtype.ext
    exact hvalue

end Ising3DCut.NullModel
