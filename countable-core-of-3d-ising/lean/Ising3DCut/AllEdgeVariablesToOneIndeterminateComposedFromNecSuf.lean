import Ising3DCut.NecSuf.AllEdgeVariablesToOneIndeterminateComposed
import Ising3DCut.AllEdgeVariablesToOneIndeterminateStepTwo

/-!
必要十分版（合成）を `R := ℤ`・具体箱型 `Config L`・破れ辺集合 `brokenSet` へ特殊化し、
具体版の合成 `κ_L(𝒵_L) = Z_L(X)` を導出する。水準集合の和から `partitionPolynomial L` への
読み替えは、具体版の第二歩を必要十分版の第二歩で書き戻して得る。
-/

namespace Ising3DCut.NullModel

open Polynomial

theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial_fromNecSuf
    (L : ℕ) :
    allEdgesToOneIndeterminate
        (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
      partitionPolynomial L := by
  have hN : ∀ σ : Config L, (brokenSet σ).card ≤ Fintype.card (Edge L) :=
    fun σ => Finset.card_le_univ _
  refine (NecSuf.allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_sum_levelSet_card_smul
      (R := ℤ) (fun σ : Config L => brokenSet σ) (Fintype.card (Edge L)) hN).trans ?_
  rw [← sum_X_pow_brokenCount_eq_partitionPolynomial L,
    NecSuf.sum_X_pow_eq_sum_levelSet_card_smul (R := ℤ) brokenCount (Fintype.card (Edge L)) hN]
  rfl

end Ising3DCut.NullModel
