/-
正本: content/finite-bath-count-canonical-boundary.ts の具体版。

二つの有限セル集合上の二値配位と整数値観測に固定し、有限殻の繊維分解、
状態数比の有理周辺分布、正の台での実指数形との一致、零重みの有限反例を
本文と同じ順序で示す。零の対数、無限和、極限、完備化、複素数体は使わない。
-/
import CellularAutomata.EssentialDependency
import Mathlib

namespace CellularAutomata.FiniteBathCountCanonicalBoundary

open scoped BigOperators
open CellularAutomata.EssentialDependency

noncomputable section

variable {VA VB : Type} [Fintype VA] [DecidableEq VA] [Fintype VB] [DecidableEq VB]

/-! ## 二つの有限二値配位集合と整数値観測 -/

/-- 第二配位集合の整数値観測 `k` の繊維の元数。 -/
def secondMultiplicity (HB : (VB → State) → ℤ) (k : ℤ) : ℕ :=
  (Finset.univ.filter fun y : VB → State => HB y = k).card

/-- 二つの整数値観測の和が `U` である配位対の有限殻。 -/
def totalShell (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ)
    (U : ℤ) : Finset ((VA → State) × (VB → State)) :=
  Finset.univ.filter fun pair => HA pair.1 + HB pair.2 = U

/-- 第一配位を固定した殻の繊維は、第二観測の対応する繊維と等濃度である。 -/
theorem shellFiber_card (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ)
    (U : ℤ) (x : VA → State) :
    ((totalShell HA HB U).filter fun pair => pair.1 = x).card =
      secondMultiplicity HB (U - HA x) := by
  classical
  apply Finset.card_bij (fun pair _ => pair.2)
  · intro pair hpair
    simp only [Finset.mem_filter] at hpair
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    rcases hpair with ⟨hshell, hfirst⟩
    have hshell' : HA pair.1 + HB pair.2 = U := by
      simpa [totalShell] using hshell
    rw [hfirst] at hshell'
    omega
  · intro left hleft right hright hsecond
    simp only [Finset.mem_filter] at hleft hright
    apply Prod.ext
    · exact hleft.2.trans hright.2.symm
    · exact hsecond
  · intro y hy
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hy
    refine ⟨(x, y), ?_, rfl⟩
    simp only [Finset.mem_filter]
    constructor
    · simp only [totalShell, Finset.mem_filter, Finset.mem_univ, true_and]
      omega
    · simp

/-- 有限殻の元数は、第一配位ごとの第二多重度の有限和である。 -/
theorem totalShell_card_eq_sum_multiplicity
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ) :
    (totalShell HA HB U).card =
      ∑ x : VA → State, secondMultiplicity HB (U - HA x) := by
  classical
  rw [Finset.card_eq_sum_card_fiberwise
    (s := totalShell HA HB U) (t := Finset.univ) (f := Prod.fst) (by simp)]
  apply Finset.sum_congr rfl
  intro x _
  exact shellFiber_card HA HB U x

/-! ## 有限殻から作る状態数比の有理分布 -/

/-- 正の有限殻上で定義される、第二多重度と殻の元数の比。 -/
def countDistribution
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (_hShell : (totalShell HA HB U).card ≠ 0) (x : VA → State) : ℚ :=
  (secondMultiplicity HB (U - HA x) : ℚ) / (totalShell HA HB U).card

/-- 有限殻上一様分布の第一周辺分布を、第一成分の繊維元数で書く。 -/
def uniformShellFirstMarginal
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (_hShell : (totalShell HA HB U).card ≠ 0) (x : VA → State) : ℚ :=
  (((totalShell HA HB U).filter fun pair => pair.1 = x).card : ℚ) /
    (totalShell HA HB U).card

/-- 状態数比は有限殻上一様分布の第一周辺分布である。 -/
theorem countDistribution_eq_uniformShellFirstMarginal
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0) (x : VA → State) :
    countDistribution HA HB U hShell x =
      uniformShellFirstMarginal HA HB U hShell x := by
  unfold countDistribution uniformShellFirstMarginal
  rw [shellFiber_card HA HB U x]

/-- 状態数比の全成分の有限和は一である。 -/
theorem countDistribution_sum_one
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0) :
    ∑ x : VA → State, countDistribution HA HB U hShell x = 1 := by
  classical
  simp only [countDistribution, ← Finset.sum_div]
  rw [← Nat.cast_sum, ← totalShell_card_eq_sum_multiplicity HA HB U]
  exact div_self (by exact_mod_cast hShell)

/-! ## 正の台での実指数形との比較 -/

/-- 正の第二多重度の負の実対数として作る有限実数値観測。 -/
def countEnergy
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (x : VA → State) : ℝ :=
  -Real.log (secondMultiplicity HB (U - HA x) : ℝ)

/-- 有限実数値観測から作る実指数分配和。 -/
def exponentialPartitionSum (E : (VA → State) → ℝ) (beta : ℝ) : ℝ :=
  ∑ z : VA → State, Real.exp (-beta * E z)

/-- 有限実数値観測から作る実指数規格化分布。 -/
def exponentialDistribution (E : (VA → State) → ℝ) (beta : ℝ)
    (x : VA → State) : ℝ :=
  Real.exp (-beta * E x) / exponentialPartitionSum E beta

theorem exponentialPartitionSum_pos (E : (VA → State) → ℝ) (beta : ℝ) :
    0 < exponentialPartitionSum E beta := by
  classical
  let zeroConfig : VA → State := fun _ => State.zero
  have hNonempty : (Finset.univ : Finset (VA → State)).Nonempty :=
    ⟨zeroConfig, Finset.mem_univ zeroConfig⟩
  unfold exponentialPartitionSum
  exact Finset.sum_pos (fun z _ => Real.exp_pos _) hNonempty

theorem exponentialDistribution_pos (E : (VA → State) → ℝ) (beta : ℝ)
    (x : VA → State) : 0 < exponentialDistribution E beta x := by
  exact div_pos (Real.exp_pos _) (exponentialPartitionSum_pos E beta)

omit [Fintype VA] [DecidableEq VA] in
/-- 正の多重度を負の実対数へ送って再指数化すると、元の多重度に戻る。 -/
theorem exp_neg_countEnergy
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hPositive : ∀ x : VA → State, 0 < secondMultiplicity HB (U - HA x))
    (x : VA → State) :
    Real.exp (-countEnergy HA HB U x) = secondMultiplicity HB (U - HA x) := by
  rw [countEnergy, neg_neg]
  exact Real.exp_log (by exact_mod_cast hPositive x)

/-- 正の台では状態数比分布の標準実数像が実指数規格化分布に一致する。 -/
theorem countDistribution_eq_exponential
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0)
    (hPositive : ∀ x : VA → State, 0 < secondMultiplicity HB (U - HA x))
    (x : VA → State) :
    (countDistribution HA HB U hShell x : ℝ) =
      exponentialDistribution (countEnergy HA HB U) 1 x := by
  classical
  unfold exponentialDistribution exponentialPartitionSum
  simp only [neg_one_mul]
  rw [exp_neg_countEnergy HA HB U hPositive x]
  simp_rw [exp_neg_countEnergy HA HB U hPositive]
  rw [← Nat.cast_sum, ← totalShell_card_eq_sum_multiplicity HA HB U]
  unfold countDistribution
  push_cast
  rfl

/-! ## 一セルずつの零重み反例 -/

def zeroConfiguration : Fin 1 → State := fun _ => State.zero
def oneConfiguration : Fin 1 → State := fun _ => State.one

def firstObservation : (Fin 1 → State) → ℤ
  | x => if x 0 = State.zero then 0 else 1

def secondObservation (_ : Fin 1 → State) : ℤ := 0

theorem counterexample_shell_nonzero :
    (totalShell firstObservation secondObservation 0).card ≠ 0 := by native_decide

theorem counterexample_count_values :
    countDistribution firstObservation secondObservation 0 counterexample_shell_nonzero
        zeroConfiguration = 1 ∧
    countDistribution firstObservation secondObservation 0 counterexample_shell_nonzero
        oneConfiguration = 0 := by
  native_decide

/-- 零成分を持つ状態数比分布は、有限実数値の指数形とは一致しない。 -/
theorem counterexample_not_exponential (E : (Fin 1 → State) → ℝ) (beta : ℝ) :
    (countDistribution firstObservation secondObservation 0 counterexample_shell_nonzero
        oneConfiguration : ℝ) ≠ exponentialDistribution E beta oneConfiguration := by
  rw [counterexample_count_values.2]
  norm_num
  exact ne_of_lt (exponentialDistribution_pos E beta oneConfiguration)

end

end CellularAutomata.FiniteBathCountCanonicalBoundary
