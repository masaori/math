import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantZeroTerms

namespace Ising2DLambda.AlgebraicEigenvalue

noncomputable def blockRestriction {J K : Type*} [Fintype J] [Fintype K]
    [DecidableEq J] [DecidableEq K] (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k : K) :
    Equiv.Perm {j : J // block j = k} := by
  let forward : {j : J // block j = k} → {j : J // block j = k} :=
    fun j => ⟨σ.1 j.1, (σ.2 j.1).trans j.2⟩
  apply Equiv.ofBijective forward
  constructor
  · intro i j hij
    exact Subtype.ext (σ.1.injective (congrArg Subtype.val hij))
  · intro j
    let i : J := σ.1.symm j.1
    have hi : block i = k := by
      calc
        block i = block (σ.1 i) := (σ.2 i).symm
        _ = block j.1 := by rw [Equiv.apply_symm_apply]
        _ = k := j.2
    exact ⟨⟨i, hi⟩, Subtype.ext (Equiv.apply_symm_apply σ.1 j.1)⟩

noncomputable def blockGluing {J K : Type*} [Fintype J] [Fintype K]
    [DecidableEq J] [DecidableEq K] (block : J → K)
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k}) :
    {σ : Equiv.Perm J // ∀ j, block (σ j) = block j} := by
  let e : Equiv.Perm J :=
    (Equiv.sigmaFiberEquiv block).symm |>.trans
      ((Equiv.sigmaCongrRight parts).trans (Equiv.sigmaFiberEquiv block))
  refine ⟨e, ?_⟩
  intro j
  exact (parts (block j) ⟨j, rfl⟩).2

theorem blockRestriction_blockGluing {J K : Type*} [Fintype J] [Fintype K]
    [DecidableEq J] [DecidableEq K] (block : J → K)
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k}) (k : K) :
    blockRestriction block (blockGluing block parts) k = parts k := by
  apply Equiv.ext
  intro j
  apply Subtype.ext
  cases j with
  | mk v hv =>
    subst k
    rfl

theorem blockGluing_blockRestriction {J K : Type*} [Fintype J] [Fintype K]
    [DecidableEq J] [DecidableEq K] (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) :
    blockGluing block (blockRestriction block σ) = σ := by
  apply Subtype.ext
  apply Equiv.ext
  intro j
  rfl

noncomputable def blockPreservingPermutationEquiv {J K : Type*} [Fintype J] [Fintype K]
    [DecidableEq J] [DecidableEq K] (block : J → K) :
    {σ : Equiv.Perm J // ∀ j, block (σ j) = block j} ≃
      (∀ k : K, Equiv.Perm {j : J // block j = k}) where
  toFun σ k := blockRestriction block σ k
  invFun parts := blockGluing block parts
  left_inv σ := blockGluing_blockRestriction block σ
  right_inv parts := funext (blockRestriction_blockGluing block parts)

end Ising2DLambda.AlgebraicEigenvalue
