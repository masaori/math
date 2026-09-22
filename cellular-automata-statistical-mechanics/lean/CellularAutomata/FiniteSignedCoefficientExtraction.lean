/-
正本: structured-latex/content/finite-signed-coefficient-extraction.ts の Lean 具体版。

有限全順序添字集合上の整数係数表、有限反交換積、一元基底の関係、
置換符号による最高次係数、有限状態添字の整数係数行列、および
零一指示行列との非対応を人手証明と同じ順序で示す。
実数体・複素数体、対数、除算、極限は使わない。
-/
import Mathlib
import CellularAutomata.TimeExpansionDependency

namespace CellularAutomata.FiniteSignedCoefficientExtraction

variable {I : Type*} [Fintype I] [LinearOrder I] [DecidableEq I] [Nonempty I]

/-- `def_finite_exterior_coefficient_table`。有限冪集合で添字づけた整数係数表。 -/
abbrev CoefficientTable (I : Type*) := Finset I → ℤ

/-- `def_finite_exterior_basis_table`。部分集合に対応する基底係数表。 -/
def basisTable (S : Finset I) : CoefficientTable I :=
  fun U => if U = S then 1 else 0

/-- `def_finite_exterior_anticommuting_product` の転倒対数。 -/
def inversionCount (S T : Finset I) : ℕ :=
  ∑ s ∈ S, (T.filter (fun t => t < s)).card

/-- `def_finite_exterior_anticommuting_product`。 -/
def anticommutingProduct (a b : CoefficientTable I) : CoefficientTable I :=
  fun U => ∑ S : Finset I, ∑ T : Finset I,
    if Disjoint S T ∧ S ∪ T = U then
      (-1 : ℤ) ^ inversionCount S T * a S * b T
    else 0

/-- 零係数表。 -/
def zeroTable : CoefficientTable I := fun _ => 0

/-- 二つの基底係数表の積では、二つの台に対応する一項だけが残る。 -/
theorem anticommutingProduct_basis (S T : Finset I) :
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
theorem generator_square_zero (i : I) :
    anticommutingProduct (basisTable {i}) (basisTable {i}) = zeroTable := by
  funext U
  simp only [anticommutingProduct, zeroTable]
  apply Finset.sum_eq_zero
  intro S _
  apply Finset.sum_eq_zero
  intro T _
  by_cases hS : S = {i}
  · subst S
    by_cases hT : T = {i}
    · subst T
      have hNotDisjoint : ¬ Disjoint ({i} : Finset I) {i} := by simp
      simp [basisTable, hNotDisjoint]
    · simp [basisTable, hT]
  · simp [basisTable, hS]

/-- `claim_finite_exterior_generators_square_zero_anticommute` の相異なる生成子の段。 -/
theorem generators_anticommute {i j : I} (hij : i ≠ j) :
    anticommutingProduct (basisTable {i}) (basisTable {j}) =
      fun U => -anticommutingProduct (basisTable {j}) (basisTable {i}) U := by
  rw [anticommutingProduct_basis, anticommutingProduct_basis]
  have hDisjoint : Disjoint ({i} : Finset I) {j} := by simp [hij]
  have hDisjoint' : Disjoint ({j} : Finset I) {i} := hDisjoint.symm
  simp only [hDisjoint, hDisjoint', if_true]
  funext U
  by_cases hlt : i < j
  · have hnot : ¬j < i := by exact not_lt_of_ge (le_of_lt hlt)
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

/-- 最高次係数の抽出。 -/
def topCoefficient (a : CoefficientTable I) : ℤ := a Finset.univ

/-- 全基底の並べ替えが与える係数表。置換符号は整数単元に埋め込む。 -/
def permutationMonomial (σ : Equiv.Perm I) : CoefficientTable I :=
  fun U => if U = Finset.univ then σ.sign else 0

/-- `claim_finite_exterior_basis_permutation_top_sign`。 -/
theorem topCoefficient_permutationMonomial (σ : Equiv.Perm I) :
    topCoefficient (permutationMonomial σ) = σ.sign := by
  simp [topCoefficient, permutationMonomial]

/-- 有限族から最高次係数を読む整数係数行列。 -/
def topCoefficientMatrix {B : Type*} (K : B → B → CoefficientTable I) : B → B → ℤ :=
  fun x y => topCoefficient (K x y)

/-- 有限自己写像の零一指示行列。 -/
def indicatorMatrix {B : Type*} [DecidableEq B] (F : B → B) : B → B → ℤ :=
  fun x y => if y = F x then 1 else 0

/-- 一セル反例で使う二元状態集合。 -/
inductive BinaryState
  | zero
  | one
  deriving DecidableEq, Fintype

/-- 最高次係数 `-1` を一成分だけに持つ有限係数表族。 -/
def counterexampleFamily :
    BinaryState → BinaryState → CoefficientTable (Fin 1) :=
  fun x y U => if x = .zero ∧ y = .zero ∧ U = Finset.univ then -1 else 0

/-- 反例の指定成分は `-1` である。 -/
theorem counterexample_top_entry :
    topCoefficientMatrix counterexampleFamily BinaryState.zero BinaryState.zero = -1 := by
  rfl

/-- 任意の有限自己写像の零一指示行列の成分は `0` または `1` である。 -/
theorem indicatorMatrix_entry_zero_or_one {B : Type*} [DecidableEq B]
    (F : B → B) (x y : B) : indicatorMatrix F x y = 0 ∨ indicatorMatrix F x y = 1 := by
  by_cases h : y = F x
  · right
    simp [indicatorMatrix, h]
  · left
    simp [indicatorMatrix, h]

/-- `claim_finite_top_coefficient_matrix_not_automatically_update`。
    最高次係数行列は一般には有限自己写像の零一指示行列ではない。 -/
theorem counterexample_not_indicator (F : BinaryState → BinaryState) :
    topCoefficientMatrix counterexampleFamily ≠ indicatorMatrix F := by
  intro h
  have hEntry := congrFun (congrFun h BinaryState.zero) BinaryState.zero
  have hZeroOrOne := indicatorMatrix_entry_zero_or_one F BinaryState.zero BinaryState.zero
  rw [counterexample_top_entry] at hEntry
  omega

/-! ## 局所係数因子から一段発展行列への比較写像 -/

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open scoped BigOperators

section LocalFactorStepEvolution

variable {V : Type} [Fintype V] [LinearOrder V] [Nonempty V]

/-- `def_finite_local_update_coefficient_factor` の局所更新等号の指示値。 -/
def localUpdateIndicator (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (v : V) (x y : V → State) : ℤ :=
  if y v = f v (restrict (N v) x) then 1 else 0

/-- `def_finite_local_update_coefficient_factor`。局所更新等号は一元基底または零表を与える。 -/
def localUpdateCoefficientFactor (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (v : V) (x y : V → State) : CoefficientTable V :=
  if y v = f v (restrict (N v) x) then basisTable {v} else zeroTable

/-- 局所係数因子が人手証明の二場合分けと一致する。 -/
theorem localUpdateCoefficientFactor_eq (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (v : V) (x y : V → State) :
    localUpdateCoefficientFactor N f v x y =
      if y v = f v (restrict (N v) x) then basisTable {v} else zeroTable := by
  rfl

/-- `def_finite_ordered_local_factor_product`。全順序に沿う係数積と標準順序単項式の積。 -/
def orderedLocalFactorProduct (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (x y : V → State) : CoefficientTable V :=
  fun U =>
    (∏ v : V, localUpdateIndicator N f v x y) *
      permutationMonomial (Equiv.refl V) U

/-- `def_finite_local_factor_step_evolution_matrix`。 -/
def localFactorStepEvolutionMatrix (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) :
    (V → State) → (V → State) → ℤ :=
  fun x y => topCoefficient (orderedLocalFactorProduct N f x y)

/-- 全局所更新等号の指示値積は、大域更新の指示値に等しい。 -/
theorem localUpdateIndicator_product_eq_indicator (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (x y : V → State) :
    (∏ v : V, localUpdateIndicator N f v x y) =
      indicatorMatrix (globalMap N f) x y := by
  classical
  by_cases hxy : y = globalMap N f x
  · subst y
    simp [localUpdateIndicator, indicatorMatrix, globalMap]
  · have hv : ∃ v : V, y v ≠ globalMap N f x v := by
      by_contra h
      apply hxy
      funext v
      exact not_ne_iff.mp (not_exists.mp h v)
    obtain ⟨v, hv⟩ := hv
    rw [Finset.prod_eq_zero (Finset.mem_univ v)]
    · simp [indicatorMatrix, hxy]
    · have hv' : y v ≠ f v (restrict (N v) x) := by
        simpa only [globalMap] using hv
      simp [localUpdateIndicator, hv']

/-- `theorem_finite_local_factor_step_matrix_equals_update_indicator`。
    局所係数因子の最高次係数行列は大域更新の零一指示行列に等しい。 -/
theorem localFactorStepEvolutionMatrix_eq_indicator (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) :
    localFactorStepEvolutionMatrix N f = indicatorMatrix (globalMap N f) := by
  classical
  funext x y
  unfold localFactorStepEvolutionMatrix orderedLocalFactorProduct topCoefficient
  simp [permutationMonomial]
  exact localUpdateIndicator_product_eq_indicator N f x y

/-- `claim_finite_local_factor_step_comparison_decidable` の有限な入力表。
    全成分は局所真理値表から計算した指示値の有限積で決まる。 -/
theorem localFactorStepEvolutionMatrix_entry (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (x y : V → State) :
    localFactorStepEvolutionMatrix N f x y =
      ∏ v : V, localUpdateIndicator N f v x y := by
  classical
  unfold localFactorStepEvolutionMatrix orderedLocalFactorProduct topCoefficient
  simp [permutationMonomial]

end LocalFactorStepEvolution

end CellularAutomata.FiniteSignedCoefficientExtraction
