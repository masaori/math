/-
正本: structured-latex/content/finite-signed-coefficient-extraction.ts の必要十分版。

反交換積の基底計算に必要なのは、有限全順序添字型と整数係数の有限和だけである。
添字型が空でないこと、二元状態、セル、局所規則、時間発展は要らない。
整数係数行列が零一指示行列でないことには、一成分が 0 と 1 の双方と異なることだけを使う。
実数体・複素数体、対数、除算、極限は使わない。
-/
import CellularAutomata.FiniteSignedCoefficientExtraction

namespace CellularAutomata.NecSuf.FiniteSignedCoefficientExtraction

open CellularAutomata.FiniteSignedCoefficientExtraction

variable {I : Type*} [Fintype I] [LinearOrder I]

/-- 二つの基底係数表の積では、二つの台に対応する一項だけが残る。
    添字型が空でないことは使わない。 -/
theorem anticommutingProduct_basis_necSuf (S T : Finset I) :
    anticommutingProduct (basisTable S) (basisTable T) =
      if Disjoint S T then
        fun U => if S ∪ T = U then (-1 : ℤ) ^ inversionCount S T else 0
      else zeroTable := by
  classical
  funext U
  simp only [anticommutingProduct]
  rw [Fintype.sum_eq_single S]
  · rw [Fintype.sum_eq_single T]
    · by_cases hDisjoint : Disjoint S T <;>
        simp [basisTable, zeroTable, hDisjoint]
    · intro T' hne
      simp [basisTable, hne]
  · intro S' hne
    simp [basisTable, hne]

/-- 一元基底の平方では、積の和へ寄与しうる項が存在しない。 -/
theorem generator_square_zero_necSuf (i : I) :
    anticommutingProduct (basisTable {i}) (basisTable {i}) = zeroTable := by
  rw [anticommutingProduct_basis_necSuf]
  simp

/-- 相異なる一元基底は、有限全順序と整数符号だけから反交換する。 -/
theorem generators_anticommute_necSuf {i j : I} (hij : i ≠ j) :
    anticommutingProduct (basisTable {i}) (basisTable {j}) =
      fun U => -anticommutingProduct (basisTable {j}) (basisTable {i}) U := by
  rw [anticommutingProduct_basis_necSuf, anticommutingProduct_basis_necSuf]
  have hDisjoint : Disjoint ({i} : Finset I) {j} := by simp [hij]
  have hDisjoint' : Disjoint ({j} : Finset I) {i} := hDisjoint.symm
  simp only [hDisjoint, hDisjoint', if_true]
  funext U
  by_cases hlt : i < j
  · have hnot : ¬j < i := not_lt_of_ge (le_of_lt hlt)
    have hInvForward : inversionCount ({i} : Finset I) {j} = 0 := by
      unfold inversionCount
      simp only [Finset.sum_singleton]
      have hEmpty : ({j} : Finset I).filter (fun t => t < i) = ∅ := by
        apply Finset.filter_eq_empty_iff.mpr
        intro t ht
        simp only [Finset.mem_singleton] at ht
        subst t
        exact hnot
      rw [hEmpty]
      simp
    have hInvBackward : inversionCount ({j} : Finset I) {i} = 1 := by
      unfold inversionCount
      simp only [Finset.sum_singleton]
      have hFull : ({i} : Finset I).filter (fun t => t < j) = {i} := by
        apply Finset.filter_eq_self.mpr
        intro t ht
        simp only [Finset.mem_singleton] at ht
        subst t
        exact hlt
      rw [hFull]
      simp
    rw [hInvForward, hInvBackward]
    by_cases hU : {i, j} = U <;> simp [Finset.union_comm, hU]
  · have hji : j < i := lt_of_le_of_ne (le_of_not_gt hlt) (Ne.symm hij)
    have hnot : ¬i < j := hlt
    have hInvForward : inversionCount ({i} : Finset I) {j} = 1 := by
      unfold inversionCount
      simp only [Finset.sum_singleton]
      have hFull : ({j} : Finset I).filter (fun t => t < i) = {j} := by
        apply Finset.filter_eq_self.mpr
        intro t ht
        simp only [Finset.mem_singleton] at ht
        subst t
        exact hji
      rw [hFull]
      simp
    have hInvBackward : inversionCount ({j} : Finset I) {i} = 0 := by
      unfold inversionCount
      simp only [Finset.sum_singleton]
      have hEmpty : ({i} : Finset I).filter (fun t => t < j) = ∅ := by
        apply Finset.filter_eq_empty_iff.mpr
        intro t ht
        simp only [Finset.mem_singleton] at ht
        subst t
        exact hnot
      rw [hEmpty]
      simp
    rw [hInvForward, hInvBackward]
    by_cases hU : {i, j} = U <;> simp [Finset.union_comm, hU]

/-- 最高次係数を読む定義は、有限添字型だけを使う。 -/
theorem topCoefficient_permutationMonomial_necSuf (σ : Equiv.Perm I) :
    topCoefficient (permutationMonomial σ) = σ.sign := by
  simp [topCoefficient, permutationMonomial]

/--
整数係数行列の一成分が 0 と 1 の双方と異なれば、その行列は任意の自己写像の
零一指示行列と異なる。有限性、順序、係数表は使わない。
-/
theorem matrix_ne_indicator_of_entry_ne_zero_one
    {B : Type*} [DecidableEq B] (M : B → B → ℤ) (x y : B)
    (hZero : M x y ≠ 0) (hOne : M x y ≠ 1) (F : B → B) :
    M ≠ indicatorMatrix F := by
  intro h
  have hEntry := congrFun (congrFun h x) y
  rcases indicatorMatrix_entry_zero_or_one F x y with hIndicator | hIndicator
  · exact hZero (hEntry.trans hIndicator)
  · exact hOne (hEntry.trans hIndicator)

/-! ## 具体版の導出 -/

section Derivation

/-- 具体版の基底積計算は、空でないという仮定を使わない一般定理の特殊化である。 -/
theorem anticommutingProduct_basis_of_necSuf (S T : Finset I) :
    anticommutingProduct (basisTable S) (basisTable T) =
      if Disjoint S T then
        fun U => if S ∪ T = U then (-1 : ℤ) ^ inversionCount S T else 0
      else zeroTable := by
  exact anticommutingProduct_basis_necSuf S T

/-- 具体版の平方零は一般の基底積計算から得られる。 -/
theorem generator_square_zero_of_necSuf (i : I) :
    anticommutingProduct (basisTable {i}) (basisTable {i}) = zeroTable := by
  exact generator_square_zero_necSuf i

/-- 具体版の反交換関係は一般の基底積計算から得られる。 -/
theorem generators_anticommute_of_necSuf {i j : I} (hij : i ≠ j) :
    anticommutingProduct (basisTable {i}) (basisTable {j}) =
      fun U => -anticommutingProduct (basisTable {j}) (basisTable {i}) U := by
  exact generators_anticommute_necSuf hij

/-- 具体版の置換符号抽出は有限添字型だけを使う一般定理から得られる。 -/
theorem topCoefficient_permutationMonomial_of_necSuf (σ : Equiv.Perm I) :
    topCoefficient (permutationMonomial σ) = σ.sign := by
  exact topCoefficient_permutationMonomial_necSuf σ

/-- 一セル反例は、一成分が 0 と 1 の双方と異なるという一般条件を満たす。 -/
theorem counterexample_not_indicator_of_necSuf
    (F : BinaryState → BinaryState) :
    topCoefficientMatrix counterexampleFamily ≠ indicatorMatrix F := by
  apply matrix_ne_indicator_of_entry_ne_zero_one
    (topCoefficientMatrix counterexampleFamily) BinaryState.zero BinaryState.zero
  · rw [counterexample_top_entry]
    omega
  · rw [counterexample_top_entry]
    omega

end Derivation

end CellularAutomata.NecSuf.FiniteSignedCoefficientExtraction
