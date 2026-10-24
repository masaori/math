import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 相手写像が二歩の順反復を逆反復へ移す、本文の帰納法。 -/
theorem matchingPairStep_mate_iterate (τ υ : FixedPointFreeInvolution J)
    (n : ℕ) (i : J) :
    τ.val (finiteMapIterate (matchingPairStep τ υ) n i) =
      finiteMapIterate (matchingPairStep τ υ).symm n (τ.val i) := by
  induction n generalizing i with
  | zero =>
    calc
      τ.val (finiteMapIterate (matchingPairStep τ υ) 0 i) = τ.val i := rfl
      _ = finiteMapIterate (matchingPairStep τ υ).symm 0 (τ.val i) := rfl
  | succ n ih =>
    let p := matchingPairStep τ υ
    calc
      τ.val (finiteMapIterate p (n + 1) i) =
          τ.val (finiteMapIterate p n (p i)) := rfl
      _ = finiteMapIterate p.symm n (τ.val (p i)) := ih (p i)
      _ = finiteMapIterate p.symm n (τ.val (υ.val (τ.val i))) := rfl
      _ = finiteMapIterate p.symm n (p.symm (τ.val i)) := rfl
      _ = finiteMapIterate p.symm (n + 1) (τ.val i) := rfl

/-- 逆反復も同じ帰納法で順反復へ移す。 -/
theorem matchingPairStep_mate_inverse_iterate (τ υ : FixedPointFreeInvolution J)
    (n : ℕ) (i : J) :
    τ.val (finiteMapIterate (matchingPairStep τ υ).symm n i) =
      finiteMapIterate (matchingPairStep τ υ) n (τ.val i) := by
  induction n generalizing i with
  | zero =>
    calc
      τ.val (finiteMapIterate (matchingPairStep τ υ).symm 0 i) = τ.val i := rfl
      _ = finiteMapIterate (matchingPairStep τ υ) 0 (τ.val i) := rfl
  | succ n ih =>
    let p := matchingPairStep τ υ
    calc
      τ.val (finiteMapIterate p.symm (n + 1) i) =
          τ.val (finiteMapIterate p.symm n (p.symm i)) := rfl
      _ = finiteMapIterate p n (τ.val (p.symm i)) := ih (p.symm i)
      _ = finiteMapIterate p n (τ.val (τ.val (υ.val i))) := rfl
      _ = finiteMapIterate p n (υ.val i) := congrArg (finiteMapIterate p n) (τ.property.2 _)
      _ = finiteMapIterate p n (υ.val (τ.val (τ.val i))) :=
        congrArg (fun z => finiteMapIterate p n (υ.val z)) (τ.property.2 i).symm
      _ = finiteMapIterate p n (p (τ.val i)) := rfl
      _ = finiteMapIterate p (n + 1) (τ.val i) := rfl

/-- 軌道の二種類の証人に、反復の向きの交換を適用する。 -/
theorem matchingPairStep_mate_mem (τ υ : FixedPointFreeInvolution J) (i j : J)
    (h : j ∈ finitePermutationOrbit (matchingPairStep τ υ) i) :
    τ.val j ∈ finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) := by
  obtain ⟨n, h | h⟩ := h
  · refine ⟨n, Or.inr ?_⟩
    calc
      finiteMapIterate (matchingPairStep τ υ).symm n (τ.val i) =
          τ.val (finiteMapIterate (matchingPairStep τ υ) n i) :=
        (matchingPairStep_mate_iterate τ υ n i).symm
      _ = τ.val j := congrArg τ.val h
  · refine ⟨n, Or.inl ?_⟩
    calc
      finiteMapIterate (matchingPairStep τ υ) n (τ.val i) =
          τ.val (finiteMapIterate (matchingPairStep τ υ).symm n i) :=
        (matchingPairStep_mate_inverse_iterate τ υ n i).symm
      _ = τ.val j := congrArg τ.val h

/-- 両包含。逆の包含の証人は同じ相手写像で戻す。 -/
theorem matchingPairStep_mate_image (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val '' finitePermutationOrbit (matchingPairStep τ υ) i =
      finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) := by
  apply Set.Subset.antisymm
  · rintro j ⟨k, hk, rfl⟩
    exact matchingPairStep_mate_mem τ υ i k hk
  · intro j hj
    have h := matchingPairStep_mate_mem τ υ (τ.val i) j hj
    rw [τ.property.2 i] at h
    exact ⟨τ.val j, h, τ.property.2 j⟩

end Ising2DLambda.AlgebraicEigenvalue
