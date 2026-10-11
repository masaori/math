import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitInvariant

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 本文の準備の四同値。一歩の不変性を反復回数について帰納する。 -/
theorem finitePermutationOrbit_iterate_mem_iff (σ : Equiv.Perm J) (i : J)
    (n : ℕ) (y : J) :
    finiteMapIterate σ n y ∈ finitePermutationOrbit σ i ↔
      y ∈ finitePermutationOrbit σ i := by
  induction n generalizing y with
  | zero =>
    calc
      finiteMapIterate σ 0 y ∈ finitePermutationOrbit σ i ↔
          y ∈ finitePermutationOrbit σ i := Iff.rfl
  | succ n ih =>
    calc
      finiteMapIterate σ (n + 1) y ∈ finitePermutationOrbit σ i ↔
          finiteMapIterate σ n (σ y) ∈ finitePermutationOrbit σ i := Iff.rfl
      _ ↔ σ y ∈ finitePermutationOrbit σ i := ih (σ y)
      _ ↔ y ∈ finitePermutationOrbit σ i := finitePermutationOrbit_invariant σ i y

/-- 本文の逆反復の三同値。逆置換の台へ移し、順反復の結果を使って戻す。 -/
theorem finitePermutationOrbit_inverse_iterate_mem_iff (σ : Equiv.Perm J) (i : J)
    (n : ℕ) (y : J) :
    finiteMapIterate σ.symm n y ∈ finitePermutationOrbit σ i ↔
      y ∈ finitePermutationOrbit σ i := by
  calc
    finiteMapIterate σ.symm n y ∈ finitePermutationOrbit σ i ↔
        finiteMapIterate σ.symm n y ∈ finitePermutationOrbit σ.symm i := by
      rw [finitePermutationOrbit_inverse]
    _ ↔ y ∈ finitePermutationOrbit σ.symm i :=
      finitePermutationOrbit_iterate_mem_iff σ.symm i n y
    _ ↔ y ∈ finitePermutationOrbit σ i := by rw [finitePermutationOrbit_inverse]

/-- 本文の零回の等号を、始点自身へ到達する証人にする。 -/
theorem finitePermutationOrbit_self_mem (σ : Equiv.Perm J) (i : J) :
    i ∈ finitePermutationOrbit σ i := by
  refine ⟨0, Or.inl ?_⟩
  calc
    finiteMapIterate σ 0 i = i := rfl

/-- 本文の第一包含。到達証人の二方向それぞれに二同値を置く。 -/
theorem finitePermutationOrbit_subset_of_mem (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    finitePermutationOrbit σ j ⊆ finitePermutationOrbit σ i := by
  intro k hk
  obtain ⟨n, hForward | hBackward⟩ := hk
  · have hTransfer : k ∈ finitePermutationOrbit σ i ↔
        j ∈ finitePermutationOrbit σ i := by
      calc
        k ∈ finitePermutationOrbit σ i ↔
            finiteMapIterate σ n j ∈ finitePermutationOrbit σ i := by rw [hForward]
        _ ↔ j ∈ finitePermutationOrbit σ i :=
          finitePermutationOrbit_iterate_mem_iff σ i n j
    exact hTransfer.mpr h
  · have hTransfer : k ∈ finitePermutationOrbit σ i ↔
        j ∈ finitePermutationOrbit σ i := by
      calc
        k ∈ finitePermutationOrbit σ i ↔
            finiteMapIterate σ.symm n j ∈ finitePermutationOrbit σ i := by
          rw [hBackward]
        _ ↔ j ∈ finitePermutationOrbit σ i :=
          finitePermutationOrbit_inverse_iterate_mem_iff σ i n j
    exact hTransfer.mpr h

/-- 本文の逆包含の準備。仮定の到達証人と自己所属から、始点の所属を逆にする。 -/
theorem finitePermutationOrbit_mem_symm (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    i ∈ finitePermutationOrbit σ j := by
  obtain ⟨n, hForward | hBackward⟩ := h
  · have hTransfer : i ∈ finitePermutationOrbit σ j ↔
        j ∈ finitePermutationOrbit σ j := by
      calc
        i ∈ finitePermutationOrbit σ j ↔
            finiteMapIterate σ n i ∈ finitePermutationOrbit σ j :=
          (finitePermutationOrbit_iterate_mem_iff σ j n i).symm
        _ ↔ j ∈ finitePermutationOrbit σ j := by rw [hForward]
    exact hTransfer.mpr (finitePermutationOrbit_self_mem σ j)
  · have hTransfer : i ∈ finitePermutationOrbit σ j ↔
        j ∈ finitePermutationOrbit σ j := by
      calc
        i ∈ finitePermutationOrbit σ j ↔
            finiteMapIterate σ.symm n i ∈ finitePermutationOrbit σ j :=
          (finitePermutationOrbit_inverse_iterate_mem_iff σ j n i).symm
        _ ↔ j ∈ finitePermutationOrbit σ j := by rw [hBackward]
    exact hTransfer.mpr (finitePermutationOrbit_self_mem σ j)

/-- `claim_finite_permutation_orbit_basepoint`。両包含は同じ包含補題の始点を交換する。 -/
theorem finitePermutationOrbit_basepoint (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    finitePermutationOrbit σ j = finitePermutationOrbit σ i := by
  apply Set.Subset.antisymm
  · exact finitePermutationOrbit_subset_of_mem σ i j h
  · exact finitePermutationOrbit_subset_of_mem σ j i
      (finitePermutationOrbit_mem_symm σ i j h)

end Ising2DLambda.AlgebraicEigenvalue
