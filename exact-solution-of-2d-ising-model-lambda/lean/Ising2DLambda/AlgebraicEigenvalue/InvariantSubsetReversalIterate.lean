import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversal
import Mathlib.Logic.Function.Iterate

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 有限集合上の写像の自然数回の反復。零回は恒等写像。 -/
def finiteMapIterate {J : Type*} [Fintype J] (f : J → J) (n : ℕ) : J → J :=
  f^[n]

/-- 本文の十二等号。始点を任意にしたまま反復回数について帰納する。 -/
theorem invariantSubsetReversal_iterate {J : Type*} [Fintype J] [DecidableEq J]
    (C : Finset J) (σ : Equiv.Perm J) (h : ∀ i : J, σ i ∈ C ↔ i ∈ C)
    (n : ℕ) (i : J) :
    (i ∈ C → finiteMapIterate (invariantSubsetReversal C σ h) n i =
      finiteMapIterate σ.symm n i) ∧
    (i ∉ C → finiteMapIterate (invariantSubsetReversal C σ h) n i =
      finiteMapIterate σ n i) := by
  induction n generalizing i with
  | zero =>
    constructor
    · intro _
      calc
        finiteMapIterate (invariantSubsetReversal C σ h) 0 i = i := rfl
        _ = finiteMapIterate σ.symm 0 i := rfl
    · intro _
      calc
        finiteMapIterate (invariantSubsetReversal C σ h) 0 i = i := rfl
        _ = finiteMapIterate σ 0 i := rfl
  | succ n ih =>
    constructor
    · intro hi
      have hsi : σ.symm i ∈ C := (inverse_mem_invariantSubset_iff C σ h i).mpr hi
      calc
        finiteMapIterate (invariantSubsetReversal C σ h) (n + 1) i =
            finiteMapIterate (invariantSubsetReversal C σ h) n
              (invariantSubsetReversal C σ h i) := rfl
        _ = finiteMapIterate (invariantSubsetReversal C σ h) n (σ.symm i) :=
          congrArg (finiteMapIterate (invariantSubsetReversal C σ h) n)
            (show invariantSubsetReversal C σ h i = σ.symm i from if_pos hi)
        _ = finiteMapIterate σ.symm n (σ.symm i) := (ih (σ.symm i)).1 hsi
        _ = finiteMapIterate σ.symm (n + 1) i := rfl
    · intro hi
      have hsi : σ i ∉ C := fun hmem => hi ((h i).mp hmem)
      calc
        finiteMapIterate (invariantSubsetReversal C σ h) (n + 1) i =
            finiteMapIterate (invariantSubsetReversal C σ h) n
              (invariantSubsetReversal C σ h i) := rfl
        _ = finiteMapIterate (invariantSubsetReversal C σ h) n (σ i) :=
          congrArg (finiteMapIterate (invariantSubsetReversal C σ h) n)
            (show invariantSubsetReversal C σ h i = σ i from if_neg hi)
        _ = finiteMapIterate σ n (σ i) := (ih (σ i)).2 hsi
        _ = finiteMapIterate σ (n + 1) i := rfl

end Ising2DLambda.AlgebraicEigenvalue
