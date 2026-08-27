/-
「末尾周期性は剰余類ごとの末尾定数性を与える」の Lean 必要十分版。

具体版の証明が実際に使うのは、自然数で添字づけられた列と、閾値以後で
周期 `p` だけ添字を進めても値が変わらないという等式だけである。
Ising 模型・有理数・正の実数乗根・箱の点数は使わない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 閾値以後で周期 `p` を持つ任意の列は、各剰余類に沿って定数である。 -/
theorem eventuallyPeriodic_residueClassConstant
    {A : Type*} (a : ℕ → A) {L0 p : ℕ}
    (hperiodic : ∀ L, L0 ≤ L → a L = a (L + p))
    (r : ℕ) :
    ∀ k : ℕ, a (L0 + r + k * p) = a (L0 + r) := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
      have hindex : L0 + r + (k + 1) * p = (L0 + r + k * p) + p := by ring
      have hthreshold : L0 ≤ L0 + r + k * p := by omega
      calc
        a (L0 + r + (k + 1) * p) = a ((L0 + r + k * p) + p) := by rw [hindex]
        _ = a (L0 + r + k * p) := by
          rw [← hperiodic (L0 + r + k * p) hthreshold]
        _ = a (L0 + r) := ih

end Ising3DCut.NecSuf
