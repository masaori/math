/-
「末尾周期的で極限量を持つ正の有理点は 1 だけである」の Lean 必要十分版。

具体版の証明が実際に使うのは、Hausdorff 位相空間に値を持つ自然数列、正の周期、
剰余類ごとの定数性、各剰余類の添字列が無限へ進むこと、列の極限、および
末尾定数性から対象を一つに定める分類だけである。
Ising 模型・有理数・正の実数乗根・箱の点数は使わない。

削れなかった仮定：`T2Space` は、相異なる二つの定数部分列が同じ極限を持たないことに必要である。
-/
import Ising3DCut.NecSuf.ResidueClassValuesAgreeGivesEventuallyConstant
import Ising3DCut.NecSuf.ResidueClassValuesDifferNoLimitQuantity

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 末尾周期的な列が極限を持ち、末尾定数性が対象を一意に定めるなら、その対象である。 -/
theorem eventuallyPeriodicLimit_onlyTarget
    {X Q : Type*} [TopologicalSpace X] [T2Space X]
    (a : ℕ → X) (q target : Q) {L0 p : ℕ}
    (hp : 0 < p)
    (hresidue : ∀ r k : ℕ, a (L0 + r + k * p) = a (L0 + r))
    (hcofinal : ∀ r : ℕ, Tendsto (fun k : ℕ => L0 + r + k * p) atTop atTop)
    (heventuallyConstantOnlyTarget :
      (∃ c : X, ∀ L, L0 ≤ L → a L = c) → q = target)
    (hlimit : ∃ α : X, Tendsto a atTop (nhds α)) :
    q = target := by
  by_cases hagree : ∀ r : ℕ, r < p → a (L0 + r) = a (L0 + 0)
  · refine heventuallyConstantOnlyTarget ⟨a (L0 + 0), ?_⟩
    exact residueClassValuesAgree_givesEventuallyConstant a hp hresidue hagree
  · push_neg at hagree
    obtain ⟨r, _, hdiffer⟩ := hagree
    exact absurd hlimit
      (differingConstantCofinalSubsequences_noLimit
        a
        (fun k : ℕ => L0 + r + k * p)
        (fun k : ℕ => L0 + 0 + k * p)
        (hcofinal r)
        (hcofinal 0)
        (hresidue r)
        (hresidue 0)
        hdiffer)

end Ising3DCut.NecSuf
