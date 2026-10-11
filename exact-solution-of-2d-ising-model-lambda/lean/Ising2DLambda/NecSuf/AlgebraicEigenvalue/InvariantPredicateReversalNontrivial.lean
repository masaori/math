import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversalOrbit

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*}

/-- 反復の計算は任意の型と写像について成立し、有限性も全単射性も使わない。 -/
theorem iterate_swappedPair (f : α → α) (a b : α)
    (hab : f a = b) (hba : f b = a) (n : ℕ) :
    f^[n] a ∈ ({a, b} : Set α) ∧ f^[n] b ∈ ({a, b} : Set α) := by
  induction n with
  | zero =>
    constructor
    · change a ∈ ({a, b} : Set α)
      exact Set.mem_insert a {b}
    · change b ∈ ({a, b} : Set α)
      exact Set.mem_insert_of_mem a (Set.mem_singleton b)
  | succ n ih =>
    constructor
    · have hstep : f^[n + 1] a = f^[n] b := by
        calc
          f^[n + 1] a = f^[n] (f a) := rfl
          _ = f^[n] b := congrArg (f^[n]) hab
      exact hstep.symm ▸ ih.2
    · have hstep : f^[n + 1] b = f^[n] a := by
        calc
          f^[n + 1] b = f^[n] (f b) := rfl
          _ = f^[n] a := congrArg (f^[n]) hba
      exact hstep.symm ▸ ih.1

/-- 必要な有限性は当該軌道だけであり、長さが奇数という仮定からも従う。 -/
theorem permutationOrbitLength_ge_three_of_odd (σ : Equiv.Perm α) (a : α)
    (hMove : σ a ≠ a) (hOdd : Odd (permutationOrbitLength σ a)) :
    3 ≤ permutationOrbitLength σ a := by
  have ha : a ∈ permutationOrbit σ a := ⟨0, Or.inl rfl⟩
  let b := σ a
  have hb : b ∈ permutationOrbit σ a := by
    refine ⟨1, Or.inl ?_⟩
    calc
      (σ : α → α)^[1] a = (σ : α → α)^[0] (σ a) := rfl
      _ = σ a := rfl
      _ = b := rfl
  have hsub : ({a, σ a} : Set α) ⊆ permutationOrbit σ a := by
    intro j hj
    rcases Set.mem_insert_iff.mp hj with hja | hjb
    · exact hja.symm ▸ ha
    · exact (Set.mem_singleton_iff.mp hjb).symm ▸ hb
  obtain ⟨k, hk⟩ := hOdd
  have hpos : 0 < (permutationOrbit σ a).ncard := by
    change 0 < permutationOrbitLength σ a
    omega
  have hfinite := Set.finite_of_ncard_pos hpos
  have hpair : ({a, σ a} : Set α).ncard = 2 := Set.ncard_pair hMove.symm
  have htwo : 2 ≤ permutationOrbitLength σ a := by
    calc
      2 = ({a, σ a} : Set α).ncard := hpair.symm
      _ ≤ (permutationOrbit σ a).ncard := Set.ncard_le_ncard hsub hfinite
      _ = permutationOrbitLength σ a := rfl
  have hkOne : 1 ≤ k := by omega
  have hdouble : k + k ≥ 2 := by
    calc
      k + k ≥ 1 + k := Nat.add_le_add_right hkOne k
      _ ≥ 1 + 1 := Nat.add_le_add_left hkOne 1
      _ = 2 := rfl
  calc
    permutationOrbitLength σ a = k + k + 1 := by simpa only [two_mul] using hk
    _ ≥ 2 + 1 := Nat.add_le_add_right hdouble 1
    _ = 3 := rfl

/--
反転する述語の中に、不動点でない奇数軌道の始点が一つあればよい。
全体の有限性・全順序・最小元の選択・他の点の不動性は要求しない。
-/
theorem invariantPredicateReversal_ne_self_of_odd
    (p : α → Prop) [DecidablePred p] (σ : Equiv.Perm α)
    (h : ∀ i, p (σ i) ↔ p i) (a : α) (ha : p a)
    (hMove : σ a ≠ a) (hOdd : Odd (permutationOrbitLength σ a)) :
    invariantPredicateReversal p σ h ≠ σ := by
  let b := σ a
  have hthree : 3 ≤ permutationOrbitLength σ a :=
    permutationOrbitLength_ge_three_of_odd σ a hMove hOdd
  intro hEqual
  have hBackward : σ.symm a = b := by
    calc
      σ.symm a = invariantPredicateReversal p σ h a := by
        change _ = if p a then σ.symm a else σ a
        exact (if_pos ha).symm
      _ = σ a := congrArg (fun π : Equiv.Perm α => π a) hEqual
      _ = b := rfl
  have hForwardBack : σ b = a := by
    calc
      σ b = σ (σ.symm a) := congrArg σ hBackward.symm
      _ = a := σ.apply_symm_apply a
  have hBackwardBack : σ.symm b = a := by
    calc
      σ.symm b = σ.symm (σ a) := rfl
      _ = a := σ.symm_apply_apply a
  have hsub : permutationOrbit σ a ⊆ ({a, b} : Set α) := by
    intro j hj
    obtain ⟨n, hForward | hInverse⟩ := hj
    · exact hForward ▸ (iterate_swappedPair σ a b rfl hForwardBack n).1
    · exact hInverse ▸ (iterate_swappedPair σ.symm a b hBackward hBackwardBack n).1
  have hpair : ({a, b} : Set α).ncard = 2 := Set.ncard_pair hMove.symm
  have htwo : permutationOrbitLength σ a ≤ 2 := by
    calc
      permutationOrbitLength σ a = (permutationOrbit σ a).ncard := rfl
      _ ≤ ({a, b} : Set α).ncard := Set.ncard_le_ncard hsub
      _ = 2 := hpair
  omega

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
