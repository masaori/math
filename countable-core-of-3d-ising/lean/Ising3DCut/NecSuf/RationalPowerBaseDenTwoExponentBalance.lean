/-
「素数 2 についての指数の釣り合い式」の Lean 必要十分版で使う代数の骨格。

具体版から有限箱・自然数・素因子分解を落とすと、残るのは四項の加法等式と、
底の分子に由来する一項が零であることだけである。したがって可換加法モノイドまで
一般化する。零項を消す以外の性質は使わない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 四項の釣り合い式で一方の寄与が零なら、その項を消した釣り合い式が成り立つ。 -/
theorem balance_of_zero_contribution
    {A : Type*} [AddCommMonoid A] (pExp vContribution uContribution bContribution : A)
    (hbalance : pExp + vContribution = uContribution + bContribution)
    (hu : uContribution = 0) :
    pExp + vContribution = bContribution := by
  calc
    pExp + vContribution = uContribution + bContribution := hbalance
    _ = 0 + bContribution := by rw [hu]
    _ = bContribution := zero_add bContribution

end Ising3DCut.NecSuf
