import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/- 始点の変更は有限性・順序・相等判定を使わない。
両側逆による一歩の不変性と自然数反復だけが、同じ両包含の論法に必要である。 -/
variable {J : Type*}

/-- 具体版と同じ準備の四同値。一歩の不変性を反復回数について帰納する。 -/
theorem permutationOrbit_iterate_mem_iff_necSuf (σ : Equiv.Perm J) (i : J)
    (n : ℕ) (y : J) :
    (σ : J → J)^[n] y ∈ permutationOrbit σ i ↔
      y ∈ permutationOrbit σ i := by
  induction n generalizing y with
  | zero =>
    calc
      (σ : J → J)^[0] y ∈ permutationOrbit σ i ↔
          y ∈ permutationOrbit σ i := Iff.rfl
  | succ n ih =>
    calc
      (σ : J → J)^[n + 1] y ∈ permutationOrbit σ i ↔
          (σ : J → J)^[n] (σ y) ∈ permutationOrbit σ i := Iff.rfl
      _ ↔ σ y ∈ permutationOrbit σ i := ih (σ y)
      _ ↔ y ∈ permutationOrbit σ i := permutationOrbit_invariant_necSuf σ i y

/-- 具体版と同じ逆反復の三同値。 -/
theorem permutationOrbit_inverse_iterate_mem_iff_necSuf (σ : Equiv.Perm J) (i : J)
    (n : ℕ) (y : J) :
    (σ.symm : J → J)^[n] y ∈ permutationOrbit σ i ↔
      y ∈ permutationOrbit σ i := by
  calc
    (σ.symm : J → J)^[n] y ∈ permutationOrbit σ i ↔
        (σ.symm : J → J)^[n] y ∈ permutationOrbit σ.symm i := by
      rw [permutationOrbit_inverse]
    _ ↔ y ∈ permutationOrbit σ.symm i :=
      permutationOrbit_iterate_mem_iff_necSuf σ.symm i n y
    _ ↔ y ∈ permutationOrbit σ i := by rw [permutationOrbit_inverse]

/-- 具体版と同じ零回の到達証人。 -/
theorem permutationOrbit_self_mem_necSuf (σ : Equiv.Perm J) (i : J) :
    i ∈ permutationOrbit σ i := by
  refine ⟨0, Or.inl ?_⟩
  calc
    (σ : J → J)^[0] i = i := rfl

/-- 具体版と同じ第一包含。二方向の到達証人ごとに二同値を置く。 -/
theorem permutationOrbit_subset_of_mem_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ permutationOrbit σ i) :
    permutationOrbit σ j ⊆ permutationOrbit σ i := by
  intro k hk
  obtain ⟨n, hForward | hBackward⟩ := hk
  · have hTransfer : k ∈ permutationOrbit σ i ↔
        j ∈ permutationOrbit σ i := by
      calc
        k ∈ permutationOrbit σ i ↔
            (σ : J → J)^[n] j ∈ permutationOrbit σ i := by rw [hForward]
        _ ↔ j ∈ permutationOrbit σ i :=
          permutationOrbit_iterate_mem_iff_necSuf σ i n j
    exact hTransfer.mpr h
  · have hTransfer : k ∈ permutationOrbit σ i ↔
        j ∈ permutationOrbit σ i := by
      calc
        k ∈ permutationOrbit σ i ↔
            (σ.symm : J → J)^[n] j ∈ permutationOrbit σ i := by rw [hBackward]
        _ ↔ j ∈ permutationOrbit σ i :=
          permutationOrbit_inverse_iterate_mem_iff_necSuf σ i n j
    exact hTransfer.mpr h

/-- 具体版と同じ逆包含の準備。二方向それぞれの二同値と自己所属を使う。 -/
theorem permutationOrbit_mem_symm_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ permutationOrbit σ i) :
    i ∈ permutationOrbit σ j := by
  obtain ⟨n, hForward | hBackward⟩ := h
  · have hTransfer : i ∈ permutationOrbit σ j ↔
        j ∈ permutationOrbit σ j := by
      calc
        i ∈ permutationOrbit σ j ↔
            (σ : J → J)^[n] i ∈ permutationOrbit σ j :=
          (permutationOrbit_iterate_mem_iff_necSuf σ j n i).symm
        _ ↔ j ∈ permutationOrbit σ j := by rw [hForward]
    exact hTransfer.mpr (permutationOrbit_self_mem_necSuf σ j)
  · have hTransfer : i ∈ permutationOrbit σ j ↔
        j ∈ permutationOrbit σ j := by
      calc
        i ∈ permutationOrbit σ j ↔
            (σ.symm : J → J)^[n] i ∈ permutationOrbit σ j :=
          (permutationOrbit_inverse_iterate_mem_iff_necSuf σ j n i).symm
        _ ↔ j ∈ permutationOrbit σ j := by rw [hBackward]
    exact hTransfer.mpr (permutationOrbit_self_mem_necSuf σ j)

/-- `claim_finite_permutation_orbit_basepoint`。具体版と同じ両包含で閉じる。 -/
theorem permutationOrbit_basepoint_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ permutationOrbit σ i) :
    permutationOrbit σ j = permutationOrbit σ i := by
  apply Set.Subset.antisymm
  · exact permutationOrbit_subset_of_mem_necSuf σ i j h
  · exact permutationOrbit_subset_of_mem_necSuf σ j i
      (permutationOrbit_mem_symm_necSuf σ i j h)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
