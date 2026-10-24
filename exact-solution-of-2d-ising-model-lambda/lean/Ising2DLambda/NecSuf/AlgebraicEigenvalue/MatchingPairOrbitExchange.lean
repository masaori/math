import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrbitSeparation

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

/-- 軌道の交換には有限性・順序・不動点の不在は不要。両逆の構成に二つの対合性だけを使う。 -/
def involutionPairStep (τ υ : J → J) (hτ : Function.Involutive τ)
    (hυ : Function.Involutive υ) : Equiv.Perm J where
  toFun i := υ (τ i)
  invFun i := τ (υ i)
  left_inv i := by change τ (υ (υ (τ i))) = i; rw [hυ, hτ]
  right_inv i := by change υ (τ (τ (υ i))) = i; rw [hτ, hυ]

/-- 相手写像が二歩の順反復を逆反復へ移す、本文の帰納法。 -/
theorem matchingPairStep_mate_iterate (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (n : ℕ) (i : J) :
    τ (Nat.iterate (involutionPairStep τ υ hτ hυ) n i) =
      Nat.iterate (involutionPairStep τ υ hτ hυ).symm n (τ i) := by
  induction n generalizing i with
  | zero =>
    calc
      τ (Nat.iterate (involutionPairStep τ υ hτ hυ) 0 i) = τ i := rfl
      _ = Nat.iterate (involutionPairStep τ υ hτ hυ).symm 0 (τ i) := rfl
  | succ n ih =>
    let p := involutionPairStep τ υ hτ hυ
    calc
      τ (Nat.iterate p (n + 1) i) =
          τ (Nat.iterate p n (p i)) := rfl
      _ = Nat.iterate p.symm n (τ (p i)) := ih (p i)
      _ = Nat.iterate p.symm n (τ (υ (τ i))) := rfl
      _ = Nat.iterate p.symm n (p.symm (τ i)) := rfl
      _ = Nat.iterate p.symm (n + 1) (τ i) := rfl

/-- 逆反復も同じ帰納法で順反復へ移す。 -/
theorem matchingPairStep_mate_inverse_iterate (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (n : ℕ) (i : J) :
    τ (Nat.iterate (involutionPairStep τ υ hτ hυ).symm n i) =
      Nat.iterate (involutionPairStep τ υ hτ hυ) n (τ i) := by
  induction n generalizing i with
  | zero =>
    calc
      τ (Nat.iterate (involutionPairStep τ υ hτ hυ).symm 0 i) = τ i := rfl
      _ = Nat.iterate (involutionPairStep τ υ hτ hυ) 0 (τ i) := rfl
  | succ n ih =>
    let p := involutionPairStep τ υ hτ hυ
    calc
      τ (Nat.iterate p.symm (n + 1) i) =
          τ (Nat.iterate p.symm n (p.symm i)) := rfl
      _ = Nat.iterate p n (τ (p.symm i)) := ih (p.symm i)
      _ = Nat.iterate p n (τ (τ (υ i))) := rfl
      _ = Nat.iterate p n (υ i) := congrArg (Nat.iterate p n) (hτ _)
      _ = Nat.iterate p n (υ (τ (τ i))) :=
        congrArg (fun z => Nat.iterate p n (υ z)) (hτ i).symm
      _ = Nat.iterate p n (p (τ i)) := rfl
      _ = Nat.iterate p (n + 1) (τ i) := rfl

/-- 軌道の二種類の証人に、反復の向きの交換を適用する。 -/
theorem matchingPairStep_mate_mem (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) (i j : J)
    (h : j ∈ permutationOrbit (involutionPairStep τ υ hτ hυ) i) :
    τ j ∈ permutationOrbit (involutionPairStep τ υ hτ hυ) (τ i) := by
  obtain ⟨n, h | h⟩ := h
  · refine ⟨n, Or.inr ?_⟩
    calc
      Nat.iterate (involutionPairStep τ υ hτ hυ).symm n (τ i) =
          τ (Nat.iterate (involutionPairStep τ υ hτ hυ) n i) :=
        (matchingPairStep_mate_iterate τ υ hτ hυ n i).symm
      _ = τ j := congrArg τ h
  · refine ⟨n, Or.inl ?_⟩
    calc
      Nat.iterate (involutionPairStep τ υ hτ hυ) n (τ i) =
          τ (Nat.iterate (involutionPairStep τ υ hτ hυ).symm n i) :=
        (matchingPairStep_mate_inverse_iterate τ υ hτ hυ n i).symm
      _ = τ j := congrArg τ h

/-- 両包含。逆の包含の証人は同じ相手写像で戻す。 -/
theorem matchingPairStep_mate_image (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) (i : J) :
    τ '' permutationOrbit (involutionPairStep τ υ hτ hυ) i =
      permutationOrbit (involutionPairStep τ υ hτ hυ) (τ i) := by
  apply Set.Subset.antisymm
  · rintro j ⟨k, hk, rfl⟩
    exact matchingPairStep_mate_mem τ υ hτ hυ i k hk
  · intro j hj
    have h := matchingPairStep_mate_mem τ υ hτ hυ (τ i) j hj
    rw [hτ i] at h
    exact ⟨τ j, h, hτ j⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
