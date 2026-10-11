import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversal
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PiecewiseIteration
import Mathlib.Data.Set.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-
台の一致は任意の型で成り立つ。使うのは二方向の反復と、述語の内外での反復対応だけで、
有限性・順序・軌道の周期は不要である。反転写像の定義には述語の判定と両側逆が要る。
-/

/-- 順・逆の二方向の自然数反復による台。 -/
def permutationOrbit {α : Type*} (σ : Equiv.Perm α) (i : α) : Set α :=
  {j | ∃ n : ℕ, (σ : α → α)^[n] i = j ∨ (σ.symm : α → α)^[n] i = j}

/-- 台への `Set.ncard` の適用。台が有限ならその元の個数になる。 -/
noncomputable def permutationOrbitLength {α : Type*} (σ : Equiv.Perm α) (i : α) : ℕ :=
  (permutationOrbit σ i).ncard

/-- 具体版と同じ四同値。二重逆を消し、選言を交換する。 -/
theorem permutationOrbit_inverse {α : Type*} (σ : Equiv.Perm α) (i : α) :
    permutationOrbit σ.symm i = permutationOrbit σ i := by
  ext j
  calc
    j ∈ permutationOrbit σ.symm i ↔
        ∃ n : ℕ, (σ.symm : α → α)^[n] i = j ∨
          (σ.symm.symm : α → α)^[n] i = j := Iff.rfl
    _ ↔ ∃ n : ℕ, (σ.symm : α → α)^[n] i = j ∨
          (σ : α → α)^[n] i = j := Iff.rfl
    _ ↔ ∃ n : ℕ, (σ : α → α)^[n] i = j ∨
          (σ.symm : α → α)^[n] i = j := exists_congr fun _ => or_comm
    _ ↔ j ∈ permutationOrbit σ i := Iff.rfl

variable {α : Type*} (p : α → Prop) [DecidablePred p]

/-- 具体版と同じ内側四等号・外側三等号。 -/
theorem invariantPredicateReversal_inverse (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) :
    (invariantPredicateReversal p σ h).symm =
      invariantPredicateReversal p σ.symm (inverse_invariantPredicate_iff p σ h) := by
  apply Equiv.ext
  intro j
  by_cases hj : p j
  · calc
      (invariantPredicateReversal p σ h).symm j = invariantPredicateBackward p σ j := rfl
      _ = σ j := if_pos hj
      _ = σ.symm.symm j := rfl
      _ = invariantPredicateReversal p σ.symm
          (inverse_invariantPredicate_iff p σ h) j := (if_pos hj).symm
  · calc
      (invariantPredicateReversal p σ h).symm j = invariantPredicateBackward p σ j := rfl
      _ = σ.symm j := if_neg hj
      _ = invariantPredicateReversal p σ.symm
          (inverse_invariantPredicate_iff p σ h) j := (if_neg hj).symm

/-- 具体版と同じ内側六同値・外側五同値。有限性は使わない。 -/
theorem invariantPredicateReversal_orbit_necSuf (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    permutationOrbit (invariantPredicateReversal p σ h) i = permutationOrbit σ i := by
  have hinv := inverse_invariantPredicate_iff p σ h
  have hreverse := invariantPredicateReversal_inverse p σ h
  -- 既存の反復の必要十分版へ、各置換の枝の保存と一歩の一致を供給する。
  have hiterate (τ : Equiv.Perm α) (hτ : ∀ j : α, p (τ j) ↔ p j)
      (n : ℕ) (j : α) :=
    piecewise_iterate_necSuf p τ τ.symm (invariantPredicateReversal p τ hτ)
      (fun k hk => (inverse_invariantPredicate_iff p τ hτ k).mpr hk)
      (fun k hk hmem => hk ((hτ k).mp hmem))
      (fun _ hk => if_pos hk) (fun _ hk => if_neg hk) n j
  ext j
  by_cases hi : p i
  · calc
      j ∈ permutationOrbit (invariantPredicateReversal p σ h) i ↔
          ∃ n : ℕ, (invariantPredicateReversal p σ h : α → α)^[n] i = j ∨
            ((invariantPredicateReversal p σ h).symm : α → α)^[n] i = j := Iff.rfl
      _ ↔ ∃ n : ℕ, (invariantPredicateReversal p σ h : α → α)^[n] i = j ∨
            (invariantPredicateReversal p σ.symm hinv : α → α)^[n] i = j := by
        rw [hreverse]
      _ ↔ ∃ n : ℕ, (σ.symm : α → α)^[n] i = j ∨
            (invariantPredicateReversal p σ.symm hinv : α → α)^[n] i = j :=
        exists_congr fun n => by rw [(hiterate σ h n i).1 hi]
      _ ↔ ∃ n : ℕ, (σ.symm : α → α)^[n] i = j ∨
            (σ.symm.symm : α → α)^[n] i = j :=
        exists_congr fun n => by rw [(hiterate σ.symm hinv n i).1 hi]
      _ ↔ j ∈ permutationOrbit σ.symm i := Iff.rfl
      _ ↔ j ∈ permutationOrbit σ i := by rw [permutationOrbit_inverse]
  · calc
      j ∈ permutationOrbit (invariantPredicateReversal p σ h) i ↔
          ∃ n : ℕ, (invariantPredicateReversal p σ h : α → α)^[n] i = j ∨
            ((invariantPredicateReversal p σ h).symm : α → α)^[n] i = j := Iff.rfl
      _ ↔ ∃ n : ℕ, (invariantPredicateReversal p σ h : α → α)^[n] i = j ∨
            (invariantPredicateReversal p σ.symm hinv : α → α)^[n] i = j := by
        rw [hreverse]
      _ ↔ ∃ n : ℕ, (σ : α → α)^[n] i = j ∨
            (invariantPredicateReversal p σ.symm hinv : α → α)^[n] i = j :=
        exists_congr fun n => by rw [(hiterate σ h n i).2 hi]
      _ ↔ ∃ n : ℕ, (σ : α → α)^[n] i = j ∨
            (σ.symm : α → α)^[n] i = j :=
        exists_congr fun n => by rw [(hiterate σ.symm hinv n i).2 hi]
      _ ↔ j ∈ permutationOrbit σ i := Iff.rfl

/-- 具体版と同じ三等号。ここでは `Set.ncard` は集合を引数に取る関数としてしか使わない。 -/
theorem invariantPredicateReversal_orbit_ncard_necSuf (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    permutationOrbitLength (invariantPredicateReversal p σ h) i =
      permutationOrbitLength σ i := by
  calc
    permutationOrbitLength (invariantPredicateReversal p σ h) i =
        (permutationOrbit (invariantPredicateReversal p σ h) i).ncard := rfl
    _ = (permutationOrbit σ i).ncard :=
      congrArg Set.ncard (invariantPredicateReversal_orbit_necSuf p σ h i)
    _ = permutationOrbitLength σ i := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
