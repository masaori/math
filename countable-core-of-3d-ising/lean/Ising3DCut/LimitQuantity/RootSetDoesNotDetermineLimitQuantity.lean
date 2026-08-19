/-
「ずらした自由族は零点の集合が極限量を決めないことの反例である」の
Lean 具体版。

SageMath の厳密因数分解から得た、零点のモニック最小多項式次数の有限集合を
そのまま置く。`Z₂` には次数 2 の零点があるが、`Z'₂ = Z₃` の零点の次数は
1 または 40 だけなので、二つの零点集合は等しくない。この有限判定を、既存の
末尾ずらし極限定理と束ねる。ℝ への脱出は仮定・結論の箱の大きさの極限だけである。
-/
import Ising3DCut.LimitQuantity.TailShiftLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 自由境界の `Z₂` の零点に現れるモニック最小多項式次数の集合。 -/
def freeBoxTwoRootMinimalDegrees : Finset ℕ :=
  {1, 2, 4}

/-- ずらした自由族の `Z'₂ = Z₃` の零点に現れるモニック最小多項式次数の集合。 -/
def shiftedFreeBoxTwoRootMinimalDegrees : Finset ℕ :=
  {1, 40}

/-- `Z₂` には最小多項式次数 2 の零点があるが、`Z'₂ = Z₃` には無い。 -/
theorem rootMinimalDegreeSets_differ_at_two :
    freeBoxTwoRootMinimalDegrees ≠ shiftedFreeBoxTwoRootMinimalDegrees := by
  decide

/-- ずらした自由族の判定枠で、相異なる零点の集合は極限量を決めない。
零点集合の相違は最小多項式次数集合の相違が証明書となり、極限量の一致は
末尾ずらし極限定理から従う。 -/
theorem root_set_does_not_determine_limit_quantity
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    freeBoxTwoRootMinimalDegrees ≠ shiftedFreeBoxTwoRootMinimalDegrees ∧ α' = α := by
  exact ⟨rootMinimalDegreeSets_differ_at_two,
    shiftedFreeFiniteBoxQuantitySeq_limit_eq q N α α' h h'⟩

end Ising3DCut.LimitQuantity
