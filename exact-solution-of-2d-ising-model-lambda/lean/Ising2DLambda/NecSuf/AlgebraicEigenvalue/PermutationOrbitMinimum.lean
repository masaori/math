import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitBasepoint
import Mathlib.Data.Finset.Max

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 有限置換の軌道を、その点の集合として集める。 -/
noncomputable def permutationOrbitPoints (σ : Equiv.Perm J) (i : J) : Finset J := by
  classical
  exact Set.toFinset (permutationOrbit σ i)

omit [LinearOrder J] in
theorem permutationOrbitPoints_nonempty (σ : Equiv.Perm J) (i : J) :
    (permutationOrbitPoints σ i).Nonempty := by
  classical
  exact ⟨i, Set.mem_toFinset.mpr (permutationOrbit_self_mem_necSuf σ i)⟩

/-- 軌道内の最小元を、軌道の有限性と始点の所属から構成する。 -/
noncomputable def permutationOrbitMinimum (σ : Equiv.Perm J) (i : J) : J :=
  (permutationOrbitPoints σ i).min' (permutationOrbitPoints_nonempty σ i)

theorem permutationOrbitMinimum_mem (σ : Equiv.Perm J) (i : J) :
    permutationOrbitMinimum σ i ∈ permutationOrbit σ i := by
  classical
  exact Set.mem_toFinset.mp (Finset.min'_mem _ _)

theorem permutationOrbitMinimum_le (σ : Equiv.Perm J) (i j : J)
    (hj : j ∈ permutationOrbit σ i) : permutationOrbitMinimum σ i ≤ j := by
  classical
  exact Finset.min'_le _ _ (Set.mem_toFinset.mpr hj)

theorem permutationOrbitMinimum_basepoint (σ : Equiv.Perm J) (i j : J)
    (hj : j ∈ permutationOrbit σ i) :
    permutationOrbitMinimum σ j = permutationOrbitMinimum σ i := by
  have hsets := permutationOrbit_basepoint_necSuf σ i j hj
  apply le_antisymm
  · apply permutationOrbitMinimum_le
    rw [hsets]
    exact permutationOrbitMinimum_mem σ i
  · apply permutationOrbitMinimum_le
    rw [← hsets]
    exact permutationOrbitMinimum_mem σ j

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
