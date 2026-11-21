/-
# `def_dimension` の次元と mathlib の `Module.finrank` の一致

`SubspacesBasesAndDimension.lean` は人手の `def_dimension` を、mathlib の一般論を使わずに自前で定めて示した
（`matDim`。存在は `subspace_has_basis`、取り方によらないことは `bases_of_subspace_have_same_number_of_elements`）。
本文の他の Lean のファイル（`trace_of_idempotent` の `ClaimTraceOfIdempotentFromNecSuf.lean`、`check_joint_eigenspace_decomposition`
の `ClaimCheckJointEigenspace.lean` など）は次元を mathlib の `Module.finrank` で書いている。両者が同じ数であることを、
自前の基底から mathlib の `Basis` を組んで示す補題を 1 本だけ置く（README 4 節の要件 3）。
-/
import Ising2D.MathematicalTools.SubspacesBasesAndDimension.SubspacesBasesAndDimension
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

namespace Ising2D

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- `def_subspace` の部分空間を、mathlib の `Submodule` として読んだもの（台集合は同じ `U`）。 -/
def IsSubspaceMat.toSubmodule {U : Set (Matrix ι κ ℂ)} (hU : IsSubspaceMat U) : Submodule ℂ (Matrix ι κ ℂ) where
  carrier := U
  add_mem' := hU.add_mem
  zero_mem' := hU.zero_mem
  smul_mem' := hU.smul_mem

/-- **一致の補題**: `dim_ℂ U`（`def_dimension`）は、`U` を `Submodule` として読んだものの `Module.finrank` に等しい。 -/
theorem matDim_eq_finrank {U : Set (Matrix ι κ ℂ)} (hU : IsSubspaceMat U) :
    matDim U hU = Module.finrank ℂ hU.toSubmodule := by
  obtain ⟨u, hu⟩ := matDim_spec U hU
  let v : Fin (matDim U hU) → hU.toSubmodule := fun t => ⟨u t, hu.1.1 t⟩
  have hli : LinearIndependent ℂ v := by
    rw [Fintype.linearIndependent_iff]
    intro g hg
    apply hu.2 g
    have := congrArg Subtype.val hg
    simpa [v, matLinComb, Submodule.coe_sum] using this
  have hsp : ⊤ ≤ Submodule.span ℂ (Set.range v) := by
    rintro ⟨x, hx⟩ _
    obtain ⟨c, hc⟩ := hu.1.2 x hx
    have hx' : (⟨x, hx⟩ : hU.toSubmodule) = ∑ t, c t • v t := by
      ext1
      simp [v, hc, matLinComb, Submodule.coe_sum]
    rw [hx']
    exact Submodule.sum_mem _ fun t _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨t, rfl⟩)
  rw [Module.finrank_eq_card_basis (Module.Basis.mk hli hsp), Fintype.card_fin]

end Ising2D
