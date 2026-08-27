/-
人手証明「末尾周期的な有理点では剰余類ごとの部分列が定数である」
（ラベル `claim_eventually_periodic_residue_class_constant`）の Lean 具体版。

末尾周期性の等式を添字 `L0 + r + k * p` へ適用し、`k` についての自然数の
帰納法で剰余類 `r` の部分列が閾値以後で定数であることを示す。使うのは
末尾周期性の等式と自然数の加法の結合律・分配法則と帰納法だけであり、
箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicIffPowerIdentity

namespace Ising3DCut.LimitQuantity

/-- `claim_eventually_periodic_residue_class_constant` の具体版。 -/
theorem eventually_periodic_residue_class_constant (q : ℚ) {L0 p : ℕ}
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    (r : ℕ) :
    ∀ k : ℕ,
      rootSeq (isingValueSeq q) siteCountSeq (L0 + r + k * p) =
        rootSeq (isingValueSeq q) siteCountSeq (L0 + r) := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
      have hindex : L0 + r + (k + 1) * p = (L0 + r + k * p) + p := by ring
      have hthreshold : L0 ≤ L0 + r + k * p := by omega
      calc
        rootSeq (isingValueSeq q) siteCountSeq (L0 + r + (k + 1) * p)
            = rootSeq (isingValueSeq q) siteCountSeq ((L0 + r + k * p) + p) := by
              rw [hindex]
        _ = rootSeq (isingValueSeq q) siteCountSeq (L0 + r + k * p) := by
              rw [← hperiodic (L0 + r + k * p) hthreshold]
        _ = rootSeq (isingValueSeq q) siteCountSeq (L0 + r) := ih

end Ising3DCut.LimitQuantity
