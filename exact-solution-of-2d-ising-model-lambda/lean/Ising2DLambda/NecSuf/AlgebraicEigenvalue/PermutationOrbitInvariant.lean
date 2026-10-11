import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversalOrbit

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/- 台の一歩の不変性は有限性・順序・相等判定を使わない。両側逆と自然数反復だけを用いる。 -/
variable {J : Type*}

/-- 本文の準備。始点を任意にした帰納法の五等号。 -/
theorem iterate_commute_necSuf (f : J → J) (n : ℕ) (y : J) :
    f (f^[n] y) = f^[n] (f y) := by
  induction n generalizing y with
  | zero =>
    calc
      f (f^[0] y) = f y := rfl
      _ = f^[0] (f y) := rfl
  | succ n ih =>
    calc
      f (f^[n + 1] y) =
          f (f^[n] (f y)) := rfl
      _ = f^[n] (f (f y)) := ih (f y)
      _ = f^[n + 1] (f y) := rfl

/-- 到達の向きと逆向きの回数の零・後者を分ける、本文の十一等号。 -/
theorem permutationOrbit_apply_mem_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ permutationOrbit σ i) :
    σ j ∈ permutationOrbit σ i := by
  obtain ⟨n, hForward | hBackward⟩ := h
  · refine ⟨n + 1, Or.inl ?_⟩
    calc
      (σ : J → J)^[n + 1] i = (σ : J → J)^[n] (σ i) := rfl
      _ = σ ((σ : J → J)^[n] i) := (iterate_commute_necSuf σ n i).symm
      _ = σ j := congrArg σ hForward
  · cases n with
    | zero =>
      refine ⟨1, Or.inl ?_⟩
      calc
        (σ : J → J)^[1] i = (σ : J → J)^[0] (σ i) := rfl
        _ = σ i := rfl
        _ = σ ((σ.symm : J → J)^[0] i) := rfl
        _ = σ j := congrArg σ hBackward
    | succ k =>
      refine ⟨k, Or.inr ?_⟩
      calc
        (σ.symm : J → J)^[k] i =
            σ (σ.symm ((σ.symm : J → J)^[k] i)) :=
          (σ.apply_symm_apply _).symm
        _ = σ ((σ.symm : J → J)^[k] (σ.symm i)) :=
          congrArg σ (iterate_commute_necSuf σ.symm k i)
        _ = σ ((σ.symm : J → J)^[k + 1] i) := rfl
        _ = σ j := congrArg σ hBackward

/-- `claim_finite_permutation_orbit_invariant`。逆置換にも一歩の閉性を適用する。 -/
theorem permutationOrbit_invariant_necSuf (σ : Equiv.Perm J) (i j : J) :
    σ j ∈ permutationOrbit σ i ↔ j ∈ permutationOrbit σ i := by
  constructor
  · intro h
    have hTransfer : σ j ∈ permutationOrbit σ.symm i ↔
        σ j ∈ permutationOrbit σ i := by
      rw [permutationOrbit_inverse]
    have hBack := permutationOrbit_apply_mem_necSuf σ.symm i (σ j) (hTransfer.mpr h)
    have hReturn : j ∈ permutationOrbit σ i ↔
        σ.symm (σ j) ∈ permutationOrbit σ.symm i := by
      calc
        j ∈ permutationOrbit σ i ↔
            σ.symm (σ j) ∈ permutationOrbit σ i := by
          rw [σ.symm_apply_apply]
        _ ↔ σ.symm (σ j) ∈ permutationOrbit σ.symm i := by
          rw [permutationOrbit_inverse]
    exact hReturn.mpr hBack
  · exact permutationOrbit_apply_mem_necSuf σ i j

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
