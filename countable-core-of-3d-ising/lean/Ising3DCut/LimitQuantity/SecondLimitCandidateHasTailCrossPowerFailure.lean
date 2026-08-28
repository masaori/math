/-
人手証明「第二の極限量候補ではどの閾値の先にも交差冪等式の破れがある」
（ラベル `claim_second_limit_candidate_has_tail_cross_power_failure`）の Lean 具体版。

反対に、ある閾値以後の全二箱で交差冪等式が成り立つと仮定する。
正の乗根の一意性から有限箱量の列は閾値以後で一定になり、その値域は有限になる。
これは既出の「第二候補の値域は無限」に反する。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality
import Ising3DCut.LimitQuantity.EventuallyConstantIffPowerIdentity
import Ising3DCut.LimitQuantity.SecondLimitQuantityCandidateHasInfiniteRange

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `claim_second_limit_candidate_has_tail_cross_power_failure` の具体版。 -/
theorem second_limit_candidate_has_tail_cross_power_failure
    (q : ℚ) {α : ℝ} (hq : 0 < q) (hq_ne_one : q ≠ 1)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    ∀ K : ℕ, ∃ L M : ℕ,
      max K 1 ≤ L ∧ max K 1 ≤ M ∧
        isingValueSeq q L ^ siteCountSeq M ≠
          isingValueSeq q M ^ siteCountSeq L := by
  have hinfinite := second_limit_quantity_candidate_has_infinite_range
    q hq_ne_one hlimit heventuallyConstantOnlyAtOne
  intro K
  by_contra hfailure
  push_neg at hfailure
  let T := max K 1
  have hTpos : 0 < T := by
    dsimp [T]
    omega
  have hconstant : ∀ L, T ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq T := by
    intro L hL
    exact cross_power_equality_implies_posRoot_equality
      (isingValueSeq q L) (isingValueSeq q T)
      (isingValueSeq_pos hq (lt_of_lt_of_le hTpos hL))
      (isingValueSeq_pos hq hTpos)
      (siteCountSeq L) (siteCountSeq T)
      (siteCountSeq_ne_zero (lt_of_lt_of_le hTpos hL))
      (siteCountSeq_ne_zero hTpos)
      (hfailure L T hL le_rfl)
  have hfinite : (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Finite := by
    let f := rootSeq (isingValueSeq q) siteCountSeq
    refine ((Set.finite_Iio T).image f |>.union (Set.finite_singleton (f T))).subset ?_
    intro x hx
    rcases hx with ⟨L, rfl⟩
    by_cases hLT : L < T
    · exact Set.mem_union_left _ ⟨L, hLT, rfl⟩
    · exact Set.mem_union_right _ (by simp [f, hconstant L (Nat.le_of_not_gt hLT)])
  exact hinfinite hfinite

end Ising3DCut.LimitQuantity
