/-
人手証明「剰余類ごとの定数値がすべて一致すれば有限箱の量の列は末尾で定数である」
（ラベル `claim_residue_class_values_agree_gives_eventually_constant`）の Lean 具体版。

閾値以後の任意の箱幅 `L` について、自然数の除法の定理で `L - L0` を
剰余 `r` と商 `k` へ分け、`L = L0 + r + k * p` としたうえで、直前に閉じた
剰余類ごとの末尾定数性を通して `a_{L0+r}` へ落とし、仮定の共通値 `c` へ着く。
使うのは自然数の除法の定理と剰余類ごとの末尾定数性だけであり、
箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicResidueClassConstant

namespace Ising3DCut.LimitQuantity

/-- `claim_residue_class_values_agree_gives_eventually_constant` の具体版。 -/
theorem residue_class_values_agree_gives_eventually_constant (q : ℚ) {L0 p : ℕ}
    (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    {c : ℝ}
    (hagree : ∀ r : ℕ, r < p → rootSeq (isingValueSeq q) siteCountSeq (L0 + r) = c) :
    ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c := by
  intro L hL
  -- 自然数の除法の定理: `L - L0 = k * p + r`、`0 ≤ r < p`。
  have hr : (L - L0) % p < p := Nat.mod_lt _ hp
  have hdiv : (L - L0) / p * p + (L - L0) % p = L - L0 := Nat.div_add_mod' _ _
  have hindex : L = L0 + (L - L0) % p + (L - L0) / p * p := by omega
  calc
    rootSeq (isingValueSeq q) siteCountSeq L
        = rootSeq (isingValueSeq q) siteCountSeq
            (L0 + (L - L0) % p + (L - L0) / p * p) := by rw [← hindex]
    _ = rootSeq (isingValueSeq q) siteCountSeq (L0 + (L - L0) % p) :=
          eventually_periodic_residue_class_constant q hperiodic _ _
    _ = c := hagree _ hr

end Ising3DCut.LimitQuantity
