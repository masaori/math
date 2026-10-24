import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

/- 有限性・順序・最小元・不動点の不在は不要。二写像の対合性は最後の等号に、
両色反転は各場合の中間点で分岐を確定するために使う。 -/

/-- def_matching_pair_successor: 第一色では第一の相手、第二色では第二の相手へ進む。 -/
noncomputable def matchingPairSuccessor (τ υ : J → J) (C : J → Prop) (i : J) : J :=
  open Classical in if C i then τ i else υ i

/-- def_matching_pair_predecessor: 後続写像と反対の相手を選ぶ。 -/
noncomputable def matchingPairPredecessor (τ υ : J → J) (C : J → Prop) (i : J) : J :=
  open Classical in if C i then υ i else τ i

/-- claim_matching_pair_permutation: 本文の二場合と、それぞれの三等号。 -/
theorem matchingPairSuccessor_inverse (τ υ : J → J) (C : J → Prop) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ i, C (τ i) ↔ ¬ C i) (hυcolor : ∀ i, C (υ i) ↔ ¬ C i)
    (i : J) :
    matchingPairPredecessor τ υ C (matchingPairSuccessor τ υ C i) = i ∧
    matchingPairSuccessor τ υ C (matchingPairPredecessor τ υ C i) = i := by
  classical
  by_cases hi : C i
  · have htau : ¬ C (τ i) :=
      fun h => (hτcolor i).mp h hi
    have hupsilon : ¬ C (υ i) :=
      fun h => (hυcolor i).mp h hi
    constructor
    · calc
        matchingPairPredecessor τ υ C (matchingPairSuccessor τ υ C i) =
            matchingPairPredecessor τ υ C (τ i) := by rw [matchingPairSuccessor, if_pos hi]
        _ = τ (τ i) := by rw [matchingPairPredecessor, if_neg htau]
        _ = i := hτ i
    · calc
        matchingPairSuccessor τ υ C (matchingPairPredecessor τ υ C i) =
            matchingPairSuccessor τ υ C (υ i) := by rw [matchingPairPredecessor, if_pos hi]
        _ = υ (υ i) := by rw [matchingPairSuccessor, if_neg hupsilon]
        _ = i := hυ i
  · have htau : C (τ i) :=
      (hτcolor i).mpr hi
    have hupsilon : C (υ i) :=
      (hυcolor i).mpr hi
    constructor
    · calc
        matchingPairPredecessor τ υ C (matchingPairSuccessor τ υ C i) =
            matchingPairPredecessor τ υ C (υ i) := by rw [matchingPairSuccessor, if_neg hi]
        _ = υ (υ i) := by rw [matchingPairPredecessor, if_pos hupsilon]
        _ = i := hυ i
    · calc
        matchingPairSuccessor τ υ C (matchingPairPredecessor τ υ C i) =
            matchingPairSuccessor τ υ C (τ i) := by rw [matchingPairPredecessor, if_neg hi]
        _ = τ (τ i) := by rw [matchingPairSuccessor, if_pos htau]
        _ = i := hτ i

/-- 本文の互いに逆であることから得る置換。 -/
noncomputable def matchingPairPermutation (τ υ : J → J) (C : J → Prop) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ i, C (τ i) ↔ ¬ C i) (hυcolor : ∀ i, C (υ i) ↔ ¬ C i) : Equiv.Perm J where
  toFun := matchingPairSuccessor τ υ C
  invFun := matchingPairPredecessor τ υ C
  left_inv i := (matchingPairSuccessor_inverse τ υ C hτ hυ hτcolor hυcolor i).1
  right_inv i := (matchingPairSuccessor_inverse τ υ C hτ hυ hτcolor hυcolor i).2

/-- 色反転には対合性・有限性・順序を要しない。 -/
theorem matchingPairSuccessor_color_necSuf (τ υ : J → J) (C : J → Prop)
    (hτcolor : ∀ i, C (τ i) ↔ ¬ C i) (hυcolor : ∀ i, C (υ i) ↔ ¬ C i)
    (i : J) : C (matchingPairSuccessor τ υ C i) ↔ ¬ C i := by
  classical
  by_cases hi : C i
  · have hstep : matchingPairSuccessor τ υ C i = τ i := by
      rw [matchingPairSuccessor, if_pos hi]
    have hmate : ¬ C (τ i) := fun h => (hτcolor i).mp h hi
    rw [hstep]
    simp [hi, hmate]
  · have hstep : matchingPairSuccessor τ υ C i = υ i := by
      rw [matchingPairSuccessor, if_neg hi]
    have hmate : C (υ i) := (hυcolor i).mpr hi
    rw [hstep]
    simp [hi, hmate]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
