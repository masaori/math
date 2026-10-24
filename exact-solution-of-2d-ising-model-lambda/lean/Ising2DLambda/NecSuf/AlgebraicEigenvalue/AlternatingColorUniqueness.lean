import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 二つの色が一歩ごとに反転すれば、一つの軌道上では基点の色だけで決まる。 -/
theorem alternatingColor_eq_on_orbit {J : Type*} (σ : Equiv.Perm J)
    (C D : Set J)
    (hC : ∀ j, σ j ∈ C ↔ j ∉ C)
    (hD : ∀ j, σ j ∈ D ↔ j ∉ D)
    (m i : J) (hm : m ∈ C ↔ m ∈ D)
    (hi : i ∈ permutationOrbit σ m) : (i ∈ C ↔ i ∈ D) := by
  have hforward (j : J) (hj : j ∈ C ↔ j ∈ D) :
      (σ j ∈ C ↔ σ j ∈ D) := by
    rw [hC j, hD j]
    exact not_congr hj
  have hback (j : J) (hj : j ∈ C ↔ j ∈ D) :
      (σ.symm j ∈ C ↔ σ.symm j ∈ D) := by
    have hc := hC (σ.symm j)
    have hd := hD (σ.symm j)
    simp only [Equiv.apply_symm_apply] at hc hd
    tauto
  rcases hi with ⟨n, hn | hn⟩
  · subst i
    induction n with
    | zero => simpa using hm
    | succ n ih =>
      rw [Function.iterate_succ_apply']
      exact hforward _ ih
  · subst i
    induction n with
    | zero => simpa using hm
    | succ n ih =>
      rw [Function.iterate_succ_apply']
      exact hback _ ih

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
