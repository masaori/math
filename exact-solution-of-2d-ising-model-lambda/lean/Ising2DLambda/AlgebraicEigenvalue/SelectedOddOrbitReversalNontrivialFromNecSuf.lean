import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversalNontrivial
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversalFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversalNontrivial

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem selectedOddOrbitLength_ge_three_from_necSuf (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    3 ≤ finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2) := by
  classical
  have hmin : leastOddOrbitPoint σ hσ.2 ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOdd : Odd (finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2)) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbitLength_ge_three_of_odd
    σ _ (hσ.1 _) hOdd

theorem selectedOddOrbitReversal_ne_self_from_necSuf (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    selectedOddOrbitReversal σ hσ.2 ≠ σ := by
  classical
  let a := leastOddOrbitPoint σ hσ.2
  have hmin : a ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOdd : Odd (finitePermutationOrbitLength σ a) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  have ha : a ∈ selectedOddOrbitFinset σ hσ.2 := by
    change a ∈ (finitePermutationOrbit σ a).toFinset
    exact Set.mem_toFinset.mpr ⟨0, Or.inl rfl⟩
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_ne_self_of_odd
    (fun j => j ∈ selectedOddOrbitFinset σ hσ.2) σ
    (selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2) a ha (hσ.1 a) hOdd

theorem selectedOddOrbitInvolution_no_fixed_from_necSuf
    (σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}) :
    selectedOddOrbitInvolution σ ≠ σ := by
  intro h
  exact selectedOddOrbitReversal_ne_self_from_necSuf σ.val σ.property
    (congrArg Subtype.val h)

end Ising2DLambda.AlgebraicEigenvalue
