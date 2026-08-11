/-
「1 乗して 1 になる代数的数は 1 だけである」の必要十分版。

必要なのは、集合への所属が指定した元との相等と同値であることだけである。
型の代数構造、冪、単位元は要らない。
-/

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

universe u

/-- 所属が指定した元との相等に一致する集合は、その元だけからなる。 -/
theorem singleton_of_mem_iff_eq_necSuf {α : Type u} (s : Set α) (one : α)
    (hmem : ∀ w, w ∈ s ↔ w = one) : s = {one} := by
  ext w
  constructor
  · intro hw
    rw [Set.mem_singleton_iff]
    exact (hmem w).mp hw
  · intro hw
    rw [Set.mem_singleton_iff] at hw
    exact (hmem w).mpr hw

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
