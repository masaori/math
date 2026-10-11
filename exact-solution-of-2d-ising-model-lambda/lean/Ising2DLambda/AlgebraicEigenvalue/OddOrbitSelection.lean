import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalOrbit
import Mathlib.Data.Finset.Max

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

noncomputable def oddOrbitPoints (σ : Equiv.Perm J) : Finset J := by
  classical
  letI : DecidablePred (fun j => Odd (finitePermutationOrbitLength σ j)) :=
    Classical.decPred _
  exact Finset.univ.filter (fun j => Odd (finitePermutationOrbitLength σ j))

variable [LinearOrder J]

noncomputable def leastOddOrbitPoint (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) : J := (oddOrbitPoints σ).min' hσ

noncomputable def selectedOddOrbit (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) : Set J :=
  finitePermutationOrbit σ (leastOddOrbitPoint σ hσ)

/-- 本文の三同値。各点で長さの保存を使い、奇数点の集合を一致させる。 -/
theorem invariantSubsetReversal_oddOrbitPoints (C : Finset J) (σ : Equiv.Perm J)
    (hC : ∀ j, σ j ∈ C ↔ j ∈ C) :
    oddOrbitPoints (invariantSubsetReversal C σ hC) = oddOrbitPoints σ := by
  classical
  ext j
  calc
    j ∈ oddOrbitPoints (invariantSubsetReversal C σ hC) ↔
        Odd (finitePermutationOrbitLength (invariantSubsetReversal C σ hC) j) := by
      simp only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and]
    _ ↔ Odd (finitePermutationOrbitLength σ j) := by
      rw [invariantSubsetReversal_orbitLength C σ hC j]
    _ ↔ j ∈ oddOrbitPoints σ := by
      simp only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and]

theorem invariantSubsetReversal_oddOrbitPoints_nonempty (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty) :
    (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty := by
  rw [invariantSubsetReversal_oddOrbitPoints C σ hC]
  exact hσ

/-- 本文の二つの所属移送、二つの比較、反対称律による一等号。 -/
theorem invariantSubsetReversal_leastOddOrbitPoint (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty)
    (hρ : (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty) :
    leastOddOrbitPoint (invariantSubsetReversal C σ hC) hρ =
      leastOddOrbitPoint σ hσ := by
  let ρ := invariantSubsetReversal C σ hC
  have hsets : oddOrbitPoints ρ = oddOrbitPoints σ :=
    invariantSubsetReversal_oddOrbitPoints C σ hC
  have hr : leastOddOrbitPoint ρ hρ ∈ oddOrbitPoints σ := by
    have hiff : leastOddOrbitPoint ρ hρ ∈ oddOrbitPoints σ ↔
        leastOddOrbitPoint ρ hρ ∈ oddOrbitPoints ρ := by rw [hsets]
    exact hiff.mpr (Finset.min'_mem _ _)
  have hs : leastOddOrbitPoint σ hσ ∈ oddOrbitPoints ρ := by
    have hiff : leastOddOrbitPoint σ hσ ∈ oddOrbitPoints ρ ↔
        leastOddOrbitPoint σ hσ ∈ oddOrbitPoints σ := by rw [hsets]
    exact hiff.mpr (Finset.min'_mem _ _)
  have hle : leastOddOrbitPoint σ hσ ≤ leastOddOrbitPoint ρ hρ :=
    Finset.min'_le _ _ hr
  have hge : leastOddOrbitPoint ρ hρ ≤ leastOddOrbitPoint σ hσ :=
    Finset.min'_le _ _ hs
  calc
    leastOddOrbitPoint ρ hρ = leastOddOrbitPoint σ hσ := le_antisymm hge hle

/-- 本文の四等号。台の保存と最小元の一致を別の行で使う。 -/
theorem invariantSubsetReversal_selectedOddOrbit (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty)
    (hρ : (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty) :
    selectedOddOrbit (invariantSubsetReversal C σ hC) hρ = selectedOddOrbit σ hσ := by
  let ρ := invariantSubsetReversal C σ hC
  calc
    selectedOddOrbit ρ hρ = finitePermutationOrbit ρ (leastOddOrbitPoint ρ hρ) := rfl
    _ = finitePermutationOrbit σ (leastOddOrbitPoint ρ hρ) :=
      invariantSubsetReversal_orbit C σ hC _
    _ = finitePermutationOrbit σ (leastOddOrbitPoint σ hσ) :=
      congrArg (finitePermutationOrbit σ)
        (invariantSubsetReversal_leastOddOrbitPoint C σ hC hσ hρ)
    _ = selectedOddOrbit σ hσ := rfl

end Ising2DLambda.AlgebraicEigenvalue
