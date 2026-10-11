import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate
import Mathlib.Data.Set.Card

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 順向きまたは逆向きの自然数回の反復で到達する点の集合。 -/
def finitePermutationOrbit (σ : Equiv.Perm J) (i : J) : Set J :=
  {j | ∃ n : ℕ, finiteMapIterate σ n i = j ∨ finiteMapIterate σ.symm n i = j}

/-- 軌道の長さは、その有限な台の元の個数。 -/
noncomputable def finitePermutationOrbitLength (σ : Equiv.Perm J) (i : J) : ℕ :=
  (finitePermutationOrbit σ i).ncard

/-- 本文の四同値。二重逆置換を取り消して、二方向の選言を交換する。 -/
theorem finitePermutationOrbit_inverse (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbit σ.symm i = finitePermutationOrbit σ i := by
  ext j
  calc
    j ∈ finitePermutationOrbit σ.symm i ↔
        ∃ n : ℕ, finiteMapIterate σ.symm n i = j ∨
          finiteMapIterate σ.symm.symm n i = j := Iff.rfl
    _ ↔ ∃ n : ℕ, finiteMapIterate σ.symm n i = j ∨
          finiteMapIterate σ n i = j := Iff.rfl
    _ ↔ ∃ n : ℕ, finiteMapIterate σ n i = j ∨
          finiteMapIterate σ.symm n i = j := exists_congr fun _ => or_comm
    _ ↔ j ∈ finitePermutationOrbit σ i := Iff.rfl

variable [DecidableEq J]

/-- 本文の準備。内側四等号・外側三等号で逆置換と反転の順を交換する。 -/
theorem invariantSubsetReversal_inverse (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    (invariantSubsetReversal C σ h).symm =
      invariantSubsetReversal C σ.symm (inverse_mem_invariantSubset_iff C σ h) := by
  apply Equiv.ext
  intro j
  by_cases hj : j ∈ C
  · calc
      (invariantSubsetReversal C σ h).symm j = invariantSubsetBackward C σ j := rfl
      _ = σ j := if_pos hj
      _ = σ.symm.symm j := rfl
      _ = invariantSubsetReversal C σ.symm
          (inverse_mem_invariantSubset_iff C σ h) j := (if_pos hj).symm
  · calc
      (invariantSubsetReversal C σ h).symm j = invariantSubsetBackward C σ j := rfl
      _ = σ.symm j := if_neg hj
      _ = invariantSubsetReversal C σ.symm
          (inverse_mem_invariantSubset_iff C σ h) j := (if_neg hj).symm

/-- 本文の内側六同値・外側五同値。各方向に既存の反復対応を適用する。 -/
theorem invariantSubsetReversal_orbit (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    finitePermutationOrbit (invariantSubsetReversal C σ h) i =
      finitePermutationOrbit σ i := by
  have hinv := inverse_mem_invariantSubset_iff C σ h
  have hreverse := invariantSubsetReversal_inverse C σ h
  ext j
  by_cases hi : i ∈ C
  · calc
      j ∈ finitePermutationOrbit (invariantSubsetReversal C σ h) i ↔
          ∃ n : ℕ, finiteMapIterate (invariantSubsetReversal C σ h) n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ h).symm n i = j := Iff.rfl
      _ ↔ ∃ n : ℕ, finiteMapIterate (invariantSubsetReversal C σ h) n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ.symm hinv) n i = j := by
        rw [hreverse]
      _ ↔ ∃ n : ℕ, finiteMapIterate σ.symm n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ.symm hinv) n i = j :=
        exists_congr fun n => by rw [(invariantSubsetReversal_iterate C σ h n i).1 hi]
      _ ↔ ∃ n : ℕ, finiteMapIterate σ.symm n i = j ∨
            finiteMapIterate σ.symm.symm n i = j :=
        exists_congr fun n => by
          rw [(invariantSubsetReversal_iterate C σ.symm hinv n i).1 hi]
      _ ↔ j ∈ finitePermutationOrbit σ.symm i := Iff.rfl
      _ ↔ j ∈ finitePermutationOrbit σ i := by rw [finitePermutationOrbit_inverse]
  · calc
      j ∈ finitePermutationOrbit (invariantSubsetReversal C σ h) i ↔
          ∃ n : ℕ, finiteMapIterate (invariantSubsetReversal C σ h) n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ h).symm n i = j := Iff.rfl
      _ ↔ ∃ n : ℕ, finiteMapIterate (invariantSubsetReversal C σ h) n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ.symm hinv) n i = j := by
        rw [hreverse]
      _ ↔ ∃ n : ℕ, finiteMapIterate σ n i = j ∨
            finiteMapIterate (invariantSubsetReversal C σ.symm hinv) n i = j :=
        exists_congr fun n => by rw [(invariantSubsetReversal_iterate C σ h n i).2 hi]
      _ ↔ ∃ n : ℕ, finiteMapIterate σ n i = j ∨
            finiteMapIterate σ.symm n i = j :=
        exists_congr fun n => by
          rw [(invariantSubsetReversal_iterate C σ.symm hinv n i).2 hi]
      _ ↔ j ∈ finitePermutationOrbit σ i := Iff.rfl

/-- 本文の三等号。有限な台の集合等号に濃度を適用する。 -/
theorem invariantSubsetReversal_orbitLength (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    finitePermutationOrbitLength (invariantSubsetReversal C σ h) i =
      finitePermutationOrbitLength σ i := by
  calc
    finitePermutationOrbitLength (invariantSubsetReversal C σ h) i =
        (finitePermutationOrbit (invariantSubsetReversal C σ h) i).ncard := rfl
    _ = (finitePermutationOrbit σ i).ncard :=
      congrArg Set.ncard (invariantSubsetReversal_orbit C σ h i)
    _ = finitePermutationOrbitLength σ i := rfl

end Ising2DLambda.AlgebraicEigenvalue
