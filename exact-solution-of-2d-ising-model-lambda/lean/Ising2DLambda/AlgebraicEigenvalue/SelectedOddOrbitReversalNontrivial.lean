import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversal

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 二点を交換する写像の反復を、両始点について同時に帰納する。 -/
theorem finiteMapIterate_swappedPair (f : J → J) (a b : J)
    (hab : f a = b) (hba : f b = a) (n : ℕ) :
    finiteMapIterate f n a ∈ ({a, b} : Set J) ∧
      finiteMapIterate f n b ∈ ({a, b} : Set J) := by
  induction n with
  | zero =>
    constructor
    · change a ∈ ({a, b} : Set J)
      exact Set.mem_insert a {b}
    · change b ∈ ({a, b} : Set J)
      exact Set.mem_insert_of_mem a (Set.mem_singleton b)
  | succ n ih =>
    constructor
    · have hstep : finiteMapIterate f (n + 1) a = finiteMapIterate f n b := by
        calc
          finiteMapIterate f (n + 1) a = finiteMapIterate f n (f a) := rfl
          _ = finiteMapIterate f n b := congrArg (finiteMapIterate f n) hab
      exact hstep.symm ▸ ih.2
    · have hstep : finiteMapIterate f (n + 1) b = finiteMapIterate f n a := by
        calc
          finiteMapIterate f (n + 1) b = finiteMapIterate f n (f b) := rfl
          _ = finiteMapIterate f n a := congrArg (finiteMapIterate f n) hba
      exact hstep.symm ▸ ih.1

theorem finitePermutationOrbitLength_ge_three_of_odd (σ : Equiv.Perm J) (a : J)
    (hMove : σ a ≠ a) (hOdd : Odd (finitePermutationOrbitLength σ a)) :
    3 ≤ finitePermutationOrbitLength σ a := by
  have ha : a ∈ finitePermutationOrbit σ a := ⟨0, Or.inl rfl⟩
  let b := σ a
  have hb : b ∈ finitePermutationOrbit σ a := by
    refine ⟨1, Or.inl ?_⟩
    calc
      finiteMapIterate σ 1 a = finiteMapIterate σ 0 (σ a) := rfl
      _ = σ a := rfl
      _ = b := rfl
  have hsub : ({a, σ a} : Set J) ⊆ finitePermutationOrbit σ a := by
    intro j hj
    rcases Set.mem_insert_iff.mp hj with hja | hjb
    · exact hja.symm ▸ ha
    · exact (Set.mem_singleton_iff.mp hjb).symm ▸ hb
  have hpair : ({a, σ a} : Set J).ncard = 2 := Set.ncard_pair hMove.symm
  have htwo : 2 ≤ finitePermutationOrbitLength σ a := by
    calc
      2 = ({a, σ a} : Set J).ncard := hpair.symm
      _ ≤ (finitePermutationOrbit σ a).ncard := Set.ncard_le_ncard hsub
      _ = finitePermutationOrbitLength σ a := rfl
  obtain ⟨k, hk⟩ := hOdd
  have hkOne : 1 ≤ k := by omega
  have hdouble : k + k ≥ 2 := by
    calc
      k + k ≥ 1 + k := Nat.add_le_add_right hkOne k
      _ ≥ 1 + 1 := Nat.add_le_add_left hkOne 1
      _ = 2 := rfl
  calc
    finitePermutationOrbitLength σ a = k + k + 1 := by simpa only [two_mul] using hk
    _ ≥ 2 + 1 := Nat.add_le_add_right hdouble 1
    _ = 3 := rfl

variable [LinearOrder J]

theorem selectedOddOrbitLength_ge_three (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    3 ≤ finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2) := by
  classical
  have hmin : leastOddOrbitPoint σ hσ.2 ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOdd : Odd (finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2)) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  exact finitePermutationOrbitLength_ge_three_of_odd σ _ (hσ.1 _) hOdd

/-- 反転が元と同じなら順逆の反復が二点に収まり、選んだ台の長さと矛盾する。 -/
theorem selectedOddOrbitReversal_ne_self (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    selectedOddOrbitReversal σ hσ.2 ≠ σ := by
  classical
  let a := leastOddOrbitPoint σ hσ.2
  let b := σ a
  have hthree : 3 ≤ finitePermutationOrbitLength σ a :=
    selectedOddOrbitLength_ge_three σ hσ
  have ha : a ∈ selectedOddOrbitFinset σ hσ.2 := by
    change a ∈ (finitePermutationOrbit σ a).toFinset
    exact Set.mem_toFinset.mpr ⟨0, Or.inl rfl⟩
  let C := selectedOddOrbitFinset σ hσ.2
  let hC := selectedOddOrbitFinset_invariant σ hσ.2
  let τ := invariantSubsetReversal C σ hC
  have hτne : τ ≠ σ := by
    intro hEqual
    have hBackward : σ.symm a = b := by
      calc
        σ.symm a = invariantSubsetReversal C σ hC a := by
          change _ = if a ∈ C then σ.symm a else σ a
          exact (if_pos ha).symm
        _ = τ a := rfl
        _ = σ a := congrArg (fun π : Equiv.Perm J => π a) hEqual
        _ = b := rfl
    have hForwardBack : σ b = a := by
      calc
        σ b = σ (σ.symm a) := congrArg σ hBackward.symm
        _ = a := σ.apply_symm_apply a
    have hBackwardBack : σ.symm b = a := by
      calc
        σ.symm b = σ.symm (σ a) := rfl
        _ = a := σ.symm_apply_apply a
    have hsub : finitePermutationOrbit σ a ⊆ ({a, b} : Set J) := by
      intro j hj
      obtain ⟨n, hForward | hInverse⟩ := hj
      · exact hForward ▸ (finiteMapIterate_swappedPair σ a b rfl hForwardBack n).1
      · exact hInverse ▸
          (finiteMapIterate_swappedPair σ.symm a b hBackward hBackwardBack n).1
    have hpair : ({a, b} : Set J).ncard = 2 := Set.ncard_pair (hσ.1 a).symm
    have htwo : finitePermutationOrbitLength σ a ≤ 2 := by
      calc
        finitePermutationOrbitLength σ a = (finitePermutationOrbit σ a).ncard := rfl
        _ ≤ ({a, b} : Set J).ncard := Set.ncard_le_ncard hsub
        _ = 2 := hpair
    omega
  calc
    selectedOddOrbitReversal σ hσ.2 =
        invariantSubsetReversal (selectedOddOrbitFinset σ hσ.2) σ
          (selectedOddOrbitFinset_invariant σ hσ.2) := rfl
    _ = invariantSubsetReversal C σ hC := rfl
    _ = τ := rfl
    _ ≠ σ := hτne

theorem selectedOddOrbitInvolution_no_fixed
    (σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}) :
    selectedOddOrbitInvolution σ ≠ σ := by
  intro h
  exact selectedOddOrbitReversal_ne_self σ.val σ.property (congrArg Subtype.val h)

end Ising2DLambda.AlgebraicEigenvalue
