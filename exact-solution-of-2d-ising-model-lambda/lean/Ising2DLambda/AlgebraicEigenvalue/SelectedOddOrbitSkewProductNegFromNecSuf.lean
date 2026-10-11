/-
必要十分版へ選んだ奇数軌道、反対称多項式行列、定数多項式に写した符号を供給する。
軌道の不変性と符号保存は既存の導出版を使い、今回の独立具体版は呼ばない。
-/
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalSignFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.SelectedOddOrbitSkewProductNeg

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem selectedOddOrbit_skew_product_neg_from_necSuf
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j)
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    (∏ i : J, A i (selectedOddOrbitReversal σ hσ.2 i)) = -(∏ i : J, A i (σ i)) := by
  classical
  let C := selectedOddOrbitFinset σ hσ.2
  have hC := selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2
  have hmin : leastOddOrbitPoint σ hσ.2 ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOddLength : Odd (finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2)) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  have hOdd : Odd C.card := by
    change Odd (selectedOddOrbit σ hσ.2).toFinset.card
    rw [← Set.ncard_eq_toFinset_card']
    exact hOddLength
  have hReversal : selectedOddOrbitReversal σ hσ.2 =
      invariantSubsetReversal C σ hC := rfl
  rw [hReversal]
  exact NecSuf.AlgebraicEigenvalue.invariant_subset_reversal_skew_product_neg
    C σ hC hOdd A (fun j _ => hA j (σ j))

theorem selectedOddOrbit_skew_signed_term_neg_from_necSuf
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j)
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    Polynomial.C ((sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) : ℤ) : Qbar) *
        (∏ i : J, A i (selectedOddOrbitReversal σ hσ.2 i)) =
      -(Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        (∏ i : J, A i (σ i))) := by
  classical
  let C := selectedOddOrbitFinset σ hσ.2
  have hC := selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2
  have hmin : leastOddOrbitPoint σ hσ.2 ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOddLength : Odd (finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ.2)) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  have hOdd : Odd C.card := by
    change Odd (selectedOddOrbit σ hσ.2).toFinset.card
    rw [← Set.ncard_eq_toFinset_card']
    exact hOddLength
  have hReversal : selectedOddOrbitReversal σ hσ.2 =
      invariantSubsetReversal C σ hC := rfl
  have hSign : sign (fun i j : J => i < j)
      (NecSuf.AlgebraicEigenvalue.invariantPredicateReversal (fun i => i ∈ C) σ hC) =
        sign (fun i j : J => i < j) σ :=
    selectedOddOrbitReversal_sign_from_necSuf σ hσ
  rw [hReversal]
  exact NecSuf.AlgebraicEigenvalue.invariant_subset_reversal_skew_signed_term_neg
    C σ hC hOdd A (fun j _ => hA j (σ j))
    (sign (fun i j : J => i < j)) (fun n : ℤ => Polynomial.C (n : Qbar)) hSign

end Ising2DLambda.AlgebraicEigenvalue
