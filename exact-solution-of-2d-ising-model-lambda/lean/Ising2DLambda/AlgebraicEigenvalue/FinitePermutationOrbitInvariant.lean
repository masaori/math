import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalOrbit

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 本文の準備。始点を任意にした帰納法の五等号。 -/
theorem finiteMapIterate_commute (f : J → J) (n : ℕ) (y : J) :
    f (finiteMapIterate f n y) = finiteMapIterate f n (f y) := by
  induction n generalizing y with
  | zero =>
    calc
      f (finiteMapIterate f 0 y) = f y := rfl
      _ = finiteMapIterate f 0 (f y) := rfl
  | succ n ih =>
    calc
      f (finiteMapIterate f (n + 1) y) =
          f (finiteMapIterate f n (f y)) := rfl
      _ = finiteMapIterate f n (f (f y)) := ih (f y)
      _ = finiteMapIterate f (n + 1) (f y) := rfl

/-- 到達の向きと逆向きの回数の零・後者を分ける、本文の十一等号。 -/
theorem finitePermutationOrbit_apply_mem (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    σ j ∈ finitePermutationOrbit σ i := by
  obtain ⟨n, hForward | hBackward⟩ := h
  · refine ⟨n + 1, Or.inl ?_⟩
    calc
      finiteMapIterate σ (n + 1) i = finiteMapIterate σ n (σ i) := rfl
      _ = σ (finiteMapIterate σ n i) := (finiteMapIterate_commute σ n i).symm
      _ = σ j := congrArg σ hForward
  · cases n with
    | zero =>
      refine ⟨1, Or.inl ?_⟩
      calc
        finiteMapIterate σ 1 i = finiteMapIterate σ 0 (σ i) := rfl
        _ = σ i := rfl
        _ = σ (finiteMapIterate σ.symm 0 i) := rfl
        _ = σ j := congrArg σ hBackward
    | succ k =>
      refine ⟨k, Or.inr ?_⟩
      calc
        finiteMapIterate σ.symm k i =
            σ (σ.symm (finiteMapIterate σ.symm k i)) :=
          (σ.apply_symm_apply _).symm
        _ = σ (finiteMapIterate σ.symm k (σ.symm i)) :=
          congrArg σ (finiteMapIterate_commute σ.symm k i)
        _ = σ (finiteMapIterate σ.symm (k + 1) i) := rfl
        _ = σ j := congrArg σ hBackward

/-- `claim_finite_permutation_orbit_invariant`。逆置換にも一歩の閉性を適用する。 -/
theorem finitePermutationOrbit_invariant (σ : Equiv.Perm J) (i j : J) :
    σ j ∈ finitePermutationOrbit σ i ↔ j ∈ finitePermutationOrbit σ i := by
  constructor
  · intro h
    have hTransfer : σ j ∈ finitePermutationOrbit σ.symm i ↔
        σ j ∈ finitePermutationOrbit σ i := by
      rw [finitePermutationOrbit_inverse]
    have hBack := finitePermutationOrbit_apply_mem σ.symm i (σ j) (hTransfer.mpr h)
    have hReturn : j ∈ finitePermutationOrbit σ i ↔
        σ.symm (σ j) ∈ finitePermutationOrbit σ.symm i := by
      calc
        j ∈ finitePermutationOrbit σ i ↔
            σ.symm (σ j) ∈ finitePermutationOrbit σ i := by
          rw [σ.symm_apply_apply]
        _ ↔ σ.symm (σ j) ∈ finitePermutationOrbit σ.symm i := by
          rw [finitePermutationOrbit_inverse]
    exact hReturn.mpr hBack
  · exact finitePermutationOrbit_apply_mem σ i j

end Ising2DLambda.AlgebraicEigenvalue
