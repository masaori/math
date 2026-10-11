/-
奇数軌道の反転で反対称多項式行列の成分積が負になることの独立具体版。
本文の再添字付け、内部七等号、外側一等号、全体五等号、符号付き三等号を辿る。
零対角性は仮定せず、有限和の相殺はここでは扱わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalSign
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Ring.Parity

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 最小奇数軌道点の所属と、軌道長の定義から選んだ有限集合の奇数性を得る。 -/
theorem selectedOddOrbitFinset_card_odd (σ : Equiv.Perm J)
    (hσ : (oddOrbitPoints σ).Nonempty) : Odd (selectedOddOrbitFinset σ hσ).card := by
  classical
  have hmin : leastOddOrbitPoint σ hσ ∈ oddOrbitPoints σ := Finset.min'_mem _ _
  have hOdd : Odd (finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ)) := by
    simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hmin
  have hcard : (selectedOddOrbitFinset σ hσ).card =
      finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ) := by
    calc
      (selectedOddOrbitFinset σ hσ).card =
          (finitePermutationOrbit σ (leastOddOrbitPoint σ hσ)).ncard :=
        (Set.ncard_eq_toFinset_card' _).symm
      _ = finitePermutationOrbitLength σ (leastOddOrbitPoint σ hσ) := rfl
  exact hcard.symm ▸ hOdd

/-- 本文の内部の積の七等号。根や次数に関する性質は使わない。 -/
theorem selectedOddOrbit_skew_inside_product_neg
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j)
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    (∏ i ∈ selectedOddOrbitFinset σ hσ.2, A i (selectedOddOrbitReversal σ hσ.2 i)) =
      -(∏ i ∈ selectedOddOrbitFinset σ hσ.2, A i (σ i)) := by
  classical
  let C := selectedOddOrbitFinset σ hσ.2
  let τ := selectedOddOrbitReversal σ hσ.2
  have hC := selectedOddOrbitFinset_invariant σ hσ.2
  have hOdd : Odd C.card := selectedOddOrbitFinset_card_odd σ hσ.2
  have hInv (i : J) : σ.symm i ∈ C ↔ i ∈ C := by
    calc
      σ.symm i ∈ C ↔ σ (σ.symm i) ∈ C := (hC (σ.symm i)).symm
      _ ↔ i ∈ C := by rw [σ.apply_symm_apply i]
  have hLeft (i : J) : σ.symm (σ i) = i := σ.symm_apply_apply i
  have hRight (i : J) : σ (σ.symm i) = i := σ.apply_symm_apply i
  have hτ : τ = invariantSubsetReversal C σ
      (selectedOddOrbitFinset_invariant σ hσ.2) := rfl
  change (∏ i ∈ C, A i (τ i)) = -(∏ i ∈ C, A i (σ i))
  rw [hτ]
  calc
    (∏ i ∈ C, A i (invariantSubsetReversal C σ hC i)) =
        ∏ i ∈ C, A i (σ.symm i) := by
      refine Finset.prod_congr rfl ?_
      intro i hi
      exact congrArg (A i) (if_pos hi)
    _ = ∏ j ∈ C, A (σ j) (σ.symm (σ j)) := by
      refine Finset.prod_bij' (fun i _ => σ.symm i) (fun j _ => σ j)
        (fun i hi => (hInv i).mpr hi) (fun j hj => (hC j).mpr hj)
        (fun i _ => hRight i) (fun j _ => hLeft j) ?_
      intro i _
      rw [σ.apply_symm_apply i]
    _ = ∏ j ∈ C, A (σ j) j := by
      refine Finset.prod_congr rfl ?_
      intro j _
      exact congrArg (A (σ j)) (σ.symm_apply_apply j)
    _ = ∏ j ∈ C, -A j (σ j) := by
      exact Finset.prod_congr rfl (fun j _ => hA j (σ j))
    _ = (-1 : Polynomial Qbar) ^ C.card * (∏ j ∈ C, A j (σ j)) := Finset.prod_neg _
    _ = (-1 : Polynomial Qbar) * (∏ j ∈ C, A j (σ j)) := by rw [hOdd.neg_one_pow]
    _ = -(∏ j ∈ C, A j (σ j)) := neg_one_mul _

/-- 本文の外側の積の一等号。 -/
theorem selectedOddOrbit_outside_product
    (A : Matrix J J (Polynomial Qbar))
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    (∏ i ∈ (selectedOddOrbitFinset σ hσ.2)ᶜ, A i (selectedOddOrbitReversal σ hσ.2 i)) =
      ∏ i ∈ (selectedOddOrbitFinset σ hσ.2)ᶜ, A i (σ i) := by
  classical
  let C := selectedOddOrbitFinset σ hσ.2
  have hτ : selectedOddOrbitReversal σ hσ.2 = invariantSubsetReversal C σ
      (selectedOddOrbitFinset_invariant σ hσ.2) := rfl
  rw [hτ]
  refine Finset.prod_congr rfl ?_
  intro i hi
  exact congrArg (A i) (if_neg (Finset.mem_compl.mp hi))

/-- 本文の全体の積の五等号。具体版は必要十分版を呼ばない。 -/
theorem selectedOddOrbit_skew_product_neg
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j)
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    (∏ i : J, A i (selectedOddOrbitReversal σ hσ.2 i)) = -(∏ i : J, A i (σ i)) := by
  classical
  let C := selectedOddOrbitFinset σ hσ.2
  let τ := selectedOddOrbitReversal σ hσ.2
  calc
    (∏ i : J, A i (τ i)) =
        (∏ i ∈ C, A i (τ i)) * (∏ i ∈ Cᶜ, A i (τ i)) :=
      (Finset.prod_mul_prod_compl C _).symm
    _ = (-(∏ i ∈ C, A i (σ i))) * (∏ i ∈ Cᶜ, A i (τ i)) := by
      rw [selectedOddOrbit_skew_inside_product_neg A hA σ hσ]
    _ = (-(∏ i ∈ C, A i (σ i))) * (∏ i ∈ Cᶜ, A i (σ i)) := by
      rw [selectedOddOrbit_outside_product A σ hσ]
    _ = -((∏ i ∈ C, A i (σ i)) * (∏ i ∈ Cᶜ, A i (σ i))) := neg_mul _ _
    _ = -(∏ i : J, A i (σ i)) := congrArg Neg.neg (Finset.prod_mul_prod_compl C _)

/-- 符号保存、全成分積の反転、負号の取り出しを一等号ずつ適用する。 -/
theorem selectedOddOrbit_skew_signed_term_neg
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j)
    (σ : Equiv.Perm J) (hσ : σ ∈ oddOrbitDerangements J) :
    Polynomial.C ((sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) : ℤ) : Qbar) *
        (∏ i : J, A i (selectedOddOrbitReversal σ hσ.2 i)) =
      -(Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        (∏ i : J, A i (σ i))) := by
  classical
  let τ := selectedOddOrbitReversal σ hσ.2
  let c : Equiv.Perm J → Polynomial Qbar := fun π =>
    Polynomial.C ((sign (fun i j : J => i < j) π : ℤ) : Qbar)
  have hc : c τ = c σ := by
    calc
      c τ = Polynomial.C ((sign (fun i j : J => i < j) τ : ℤ) : Qbar) := rfl
      _ = Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) := by
        rw [selectedOddOrbitReversal_sign σ hσ]
      _ = c σ := rfl
  calc
    c τ * (∏ i : J, A i (τ i)) = c σ * (∏ i : J, A i (τ i)) := by rw [hc]
    _ = c σ * (-(∏ i : J, A i (σ i))) := by rw [selectedOddOrbit_skew_product_neg A hA σ hσ]
    _ = -(c σ * (∏ i : J, A i (σ i))) := mul_neg _ _

end Ising2DLambda.AlgebraicEigenvalue
