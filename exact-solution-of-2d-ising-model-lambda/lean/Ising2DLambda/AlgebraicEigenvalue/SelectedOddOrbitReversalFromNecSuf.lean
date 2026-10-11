/-
必要十分版へ、既存の軌道不変性と奇数軌道選択不変性の導出版を供給する。
この節の具体版の不動点保存・対象集合保存・二重反転の証明は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversal
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitInvariantFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.OddOrbitSelectionFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.SelectedPredicateReversal

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem selectedOddOrbitFinset_invariant_from_necSuf (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) (i : J) :
    σ i ∈ selectedOddOrbitFinset σ hσ ↔ i ∈ selectedOddOrbitFinset σ hσ := by
  classical
  simpa only [selectedOddOrbitFinset, Set.mem_toFinset, selectedOddOrbit] using
    finitePermutationOrbit_invariant_from_necSuf σ (leastOddOrbitPoint σ hσ) i

theorem invariantSubsetReversal_fixed_iff_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (hC : ∀ i, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetReversal C σ hC i = i ↔ σ i = i :=
  invariantPredicateReversal_fixed_iff (fun j => j ∈ C) σ hC i

theorem selectedOddOrbitReversal_mem_from_necSuf (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    selectedOddOrbitReversal σ hσ.2 ∈ oddOrbitDerangements J := by
  let C := selectedOddOrbitFinset σ hσ.2
  let hC := selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2
  exact selectedPredicateReversal_mem (fun j => j ∈ C)
    (fun π => (oddOrbitPoints π).Nonempty) σ hC hσ
    (invariantSubsetReversal_oddOrbitPoints_nonempty_from_necSuf C σ hC)

theorem selectedOddOrbitInvolution_twice_from_necSuf
    (σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}) :
    selectedOddOrbitInvolution (selectedOddOrbitInvolution σ) = σ := by
  classical
  apply Subtype.ext
  let C := selectedOddOrbitFinset σ.val σ.property.2
  let hC := selectedOddOrbitFinset_invariant_from_necSuf σ.val σ.property.2
  let τ := invariantSubsetReversal C σ.val hC
  have hτ : τ ∈ oddOrbitDerangements J :=
    selectedOddOrbitReversal_mem_from_necSuf σ.val σ.property
  let D := selectedOddOrbitFinset τ hτ.2
  let hD := selectedOddOrbitFinset_invariant_from_necSuf τ hτ.2
  have hSelected : selectedOddOrbit τ hτ.2 = selectedOddOrbit σ.val σ.property.2 :=
    invariantSubsetReversal_selectedOddOrbit_from_necSuf C σ.val hC σ.property.2 hτ.2
  have hFinset : D = C := congrArg (fun S : Set J => S.toFinset) hSelected
  have hPred : (fun j => j ∈ D) = (fun j => j ∈ C) := by rw [hFinset]
  exact selectedPredicateInvolution_twice (fun j => j ∈ C) (fun j => j ∈ D)
    σ.val hC hD hPred

end Ising2DLambda.AlgebraicEigenvalue
