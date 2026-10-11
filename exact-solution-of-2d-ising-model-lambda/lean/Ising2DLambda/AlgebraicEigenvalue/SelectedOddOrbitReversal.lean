/-
奇数軌道を持つ不動点のない置換に対し、選んだ軌道だけを反転する自己写像。
本文の台の不変性、不動性の同値、対象集合の保存、二重反転を独立に追う。
-/
import Ising2DLambda.AlgebraicEigenvalue.OddOrbitSelection
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitInvariant

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 入力の所属証明が、最小元を選ぶための非空性を含む。 -/
def oddOrbitDerangements (J : Type*) [Fintype J] : Set (Equiv.Perm J) :=
  {σ | (∀ i : J, σ i ≠ i) ∧ (oddOrbitPoints σ).Nonempty}

noncomputable def selectedOddOrbitFinset (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) : Finset J := by
  classical
  exact (selectedOddOrbit σ hσ).toFinset

theorem selectedOddOrbitFinset_invariant (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) (i : J) :
    σ i ∈ selectedOddOrbitFinset σ hσ ↔ i ∈ selectedOddOrbitFinset σ hσ := by
  classical
  calc
    (σ i ∈ selectedOddOrbitFinset σ hσ) ↔
        σ i ∈ finitePermutationOrbit σ (leastOddOrbitPoint σ hσ) := by
      simp only [selectedOddOrbitFinset, Set.mem_toFinset, selectedOddOrbit]
    _ ↔ i ∈ finitePermutationOrbit σ (leastOddOrbitPoint σ hσ) :=
      finitePermutationOrbit_invariant σ (leastOddOrbitPoint σ hσ) i
    _ ↔ i ∈ selectedOddOrbitFinset σ hσ := by
      simp only [selectedOddOrbitFinset, Set.mem_toFinset, selectedOddOrbit]

noncomputable def selectedOddOrbitReversal (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) : Equiv.Perm J :=
  invariantSubsetReversal (selectedOddOrbitFinset σ hσ) σ
    (selectedOddOrbitFinset_invariant σ hσ)

/-- 台の内側では本文の四同値、外側では定義の一同値。 -/
theorem invariantSubsetReversal_fixed_iff (C : Finset J) (σ : Equiv.Perm J)
    (hC : ∀ i, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetReversal C σ hC i = i ↔ σ i = i := by
  by_cases hi : i ∈ C
  · calc
      invariantSubsetReversal C σ hC i = i ↔ σ.symm i = i := by
        change (if i ∈ C then σ.symm i else σ i) = i ↔ _
        rw [if_pos hi]
      _ ↔ σ (σ.symm i) = σ i := σ.injective.eq_iff.symm
      _ ↔ i = σ i := by rw [σ.apply_symm_apply i]
      _ ↔ σ i = i := eq_comm
  · change (if i ∈ C then σ.symm i else σ i) = i ↔ _
    rw [if_neg hi]

theorem selectedOddOrbitReversal_mem (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    selectedOddOrbitReversal σ hσ.2 ∈ oddOrbitDerangements J := by
  let C := selectedOddOrbitFinset σ hσ.2
  let hC := selectedOddOrbitFinset_invariant σ hσ.2
  let D : Set (Equiv.Perm J) := {π | ∀ i, π i ≠ i}
  have hDer : invariantSubsetReversal C σ hC ∈ D ↔ σ ∈ D := by
    calc
      invariantSubsetReversal C σ hC ∈ D ↔
          (∀ i, invariantSubsetReversal C σ hC i ≠ i) := Iff.rfl
      _ ↔ (∀ i, σ i ≠ i) :=
        forall_congr' (fun i => not_congr (invariantSubsetReversal_fixed_iff C σ hC i))
      _ ↔ σ ∈ D := Iff.rfl
  have hOdd : oddOrbitPoints (invariantSubsetReversal C σ hC) = oddOrbitPoints σ :=
    invariantSubsetReversal_oddOrbitPoints C σ hC
  exact ⟨hDer.mpr hσ.1, hOdd.symm ▸ hσ.2⟩

/-- 対象集合が空でも、入力以外から置換や最小元を選ばない。 -/
noncomputable def selectedOddOrbitInvolution :
    {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J} →
      {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J} :=
  fun σ => ⟨selectedOddOrbitReversal σ.val σ.property.2,
    selectedOddOrbitReversal_mem σ.val σ.property⟩

theorem selectedOddOrbitInvolution_twice
    (σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}) :
    selectedOddOrbitInvolution (selectedOddOrbitInvolution σ) = σ := by
  classical
  apply Subtype.ext
  let C := selectedOddOrbitFinset σ.val σ.property.2
  let hC := selectedOddOrbitFinset_invariant σ.val σ.property.2
  let τ := invariantSubsetReversal C σ.val hC
  have hτ : τ ∈ oddOrbitDerangements J := selectedOddOrbitReversal_mem σ.val σ.property
  have hSelected : selectedOddOrbit τ hτ.2 = selectedOddOrbit σ.val σ.property.2 :=
    invariantSubsetReversal_selectedOddOrbit C σ.val hC σ.property.2 hτ.2
  have hFinset : selectedOddOrbitFinset τ hτ.2 = C :=
    congrArg (fun S : Set J => S.toFinset) hSelected
  change selectedOddOrbitReversal τ hτ.2 = σ.val
  calc
    selectedOddOrbitReversal τ hτ.2 =
        invariantSubsetReversal (selectedOddOrbitFinset τ hτ.2) τ
          (selectedOddOrbitFinset_invariant τ hτ.2) := rfl
    _ = invariantSubsetReversal (selectedOddOrbitFinset σ.val σ.property.2) τ
          (invariantSubsetReversal_mem_iff C σ.val hC) := by
      apply Equiv.ext
      intro i
      exact congrArg (fun E : Finset J => if i ∈ E then τ.symm i else τ i) hFinset
    _ = invariantSubsetReversal C τ
          (invariantSubsetReversal_mem_iff C σ.val hC) := rfl
    _ = invariantSubsetReversal C (invariantSubsetReversal C σ.val hC)
          (invariantSubsetReversal_mem_iff C σ.val hC) := rfl
    _ = σ.val := invariantSubsetReversal_twice C σ.val hC

end Ising2DLambda.AlgebraicEigenvalue
