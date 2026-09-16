/-
正本: content/finite-bath-count-canonical-boundary.ts の必要十分版。

必要な構造の検査結果:
  - 殻の元数分解には、二つの有限型と有限関係の繊維だけを要る。
  - 状態数比の正規化には、有限添字型、自然数値の有限和、有理数への埋め込みと除算だけを要る。
  - 二つの正規化分布の一致には、各未規格化重みの一致だけを要る。
  - 零重みと正の規格化重みの非一致には、線形順序体と正の有限重みだけを要る。
  - 二元状態、セル、整数値観測、局所規則、時間発展、実対数、実指数関数は、
    具体版で一般定理の仮定を供給する段階だけに残る。

具体版と同じく、有限関係を第一成分の繊維へ分解し、その元数を有限和で表す。
次に未規格化重みを有限和で割り、点ごとの重みの一致から規格化後の一致を導く。
-/
import CellularAutomata.FiniteBathCountCanonicalBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteBathCountCanonicalBoundary

open scoped BigOperators

noncomputable section

variable {X Y W : Type*}

/-! ## 有限関係の繊維分解 -/

/-- 有限関係の第一成分 `x` における繊維。 -/
def relationFiber [Fintype Y]
    (relation : X → Y → Prop) [DecidableRel relation] (x : X) : Finset Y :=
  Finset.univ.filter (relation x)

/-- 有限関係を満たす対の集合。 -/
def relationPairs [Fintype X] [Fintype Y]
    (relation : X → Y → Prop) [DecidableRel relation] : Finset (X × Y) :=
  Finset.univ.filter fun pair => relation pair.1 pair.2

/-- 有限関係を満たす対の元数は、第一成分ごとの繊維元数の和である。 -/
theorem relationPairs_card_eq_sum_fiber [Fintype X] [Fintype Y]
    (relation : X → Y → Prop) [DecidableRel relation] :
    (relationPairs relation).card = ∑ x : X, (relationFiber relation x).card := by
  classical
  rw [Finset.card_eq_sum_card_fiberwise
    (s := relationPairs relation) (t := Finset.univ) (f := Prod.fst) (by simp)]
  apply Finset.sum_congr rfl
  intro x _
  apply Finset.card_bij (fun pair _ => pair.2)
  · intro pair hpair
    simp only [Finset.mem_filter] at hpair
    have hrelation : relation pair.1 pair.2 := by
      simpa [relationPairs] using hpair.1
    rw [hpair.2] at hrelation
    simpa [relationFiber] using hrelation
  · intro left hleft right hright hsecond
    simp only [Finset.mem_filter] at hleft hright
    apply Prod.ext
    · exact hleft.2.trans hright.2.symm
    · exact hsecond
  · intro y hy
    have hyRelation : relation x y := by
      simpa [relationFiber] using hy
    refine ⟨(x, y), ?_, rfl⟩
    simp [relationPairs, hyRelation]

/-! ## 有限重みの規格化 -/

/-- 有限添字型上の重みの有限和。 -/
def finiteWeightSum [Fintype X] [AddCommMonoid W] (weight : X → W) : W :=
  ∑ x : X, weight x

/-- 零でない有限和で割った規格化重み。 -/
def normalizedFiniteWeight [Fintype X] [Field W]
    (weight : X → W) (x : X) : W :=
  weight x / finiteWeightSum weight

/-- 重みの有限和が零でなければ、規格化重みの有限和は一である。 -/
theorem normalizedFiniteWeight_sum_one [Fintype X] [Field W]
    (weight : X → W) (hsum : finiteWeightSum weight ≠ 0) :
    ∑ x : X, normalizedFiniteWeight weight x = 1 := by
  simp only [normalizedFiniteWeight, ← Finset.sum_div, finiteWeightSum]
  exact div_self hsum

/-- 点ごとに等しい二つの有限重みは、規格化後も点ごとに等しい。 -/
theorem normalizedFiniteWeight_congr [Fintype X] [Field W]
    (left right : X → W) (hweight : ∀ x, left x = right x) (x : X) :
    normalizedFiniteWeight left x = normalizedFiniteWeight right x := by
  simp only [normalizedFiniteWeight, finiteWeightSum]
  rw [hweight x]
  congr 1
  apply Finset.sum_congr rfl
  intro z _
  exact hweight z

/-- 空でない有限型上の正の重みは正の有限和を持つ。 -/
theorem finiteWeightSum_pos [Fintype X] [Nonempty X]
    [Field W] [LinearOrder W] [IsStrictOrderedRing W]
    (weight : X → W) (hpositive : ∀ x, 0 < weight x) :
    0 < finiteWeightSum weight := by
  classical
  unfold finiteWeightSum
  exact Finset.sum_pos (fun x _ => hpositive x) Finset.univ_nonempty

/-- 正の重みを正の有限和で割った規格化重みは正である。 -/
theorem normalizedFiniteWeight_pos [Fintype X] [Nonempty X]
    [Field W] [LinearOrder W] [IsStrictOrderedRing W]
    (weight : X → W) (hpositive : ∀ x, 0 < weight x) (x : X) :
    0 < normalizedFiniteWeight weight x := by
  exact div_pos (hpositive x) (finiteWeightSum_pos weight hpositive)

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.FiniteBathCountCanonicalBoundary

variable {VA VB : Type} [Fintype VA] [DecidableEq VA] [Fintype VB] [DecidableEq VB]

/-- 具体版の殻の元数分解は、有限関係の繊維分解の特殊化である。 -/
theorem totalShell_card_eq_sum_multiplicity_of_necSuf
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ) :
    (totalShell HA HB U).card =
      ∑ x : VA → State, secondMultiplicity HB (U - HA x) := by
  rw [show totalShell HA HB U =
      relationPairs (fun x y => HA x + HB y = U) by
        ext pair
        simp [totalShell, relationPairs]]
  rw [relationPairs_card_eq_sum_fiber]
  apply Finset.sum_congr rfl
  intro x _
  congr 1
  ext y
  simp [relationFiber]
  omega

/-- 具体版の状態数比分布は、自然数値多重度を有理数へ送った有限重みの規格化である。 -/
theorem countDistribution_eq_normalizedFiniteWeight
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0) (x : VA → State) :
    countDistribution HA HB U hShell x =
      normalizedFiniteWeight
        (fun z : VA → State => (secondMultiplicity HB (U - HA z) : ℚ)) x := by
  unfold countDistribution normalizedFiniteWeight finiteWeightSum
  rw [← Nat.cast_sum, ← totalShell_card_eq_sum_multiplicity_of_necSuf HA HB U]

/-- 具体版の状態数比分布の規格化は、有限重みの一般定理から得られる。 -/
theorem countDistribution_sum_one_of_necSuf
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0) :
    ∑ x : VA → State, countDistribution HA HB U hShell x = 1 := by
  simp_rw [countDistribution_eq_normalizedFiniteWeight HA HB U hShell]
  apply normalizedFiniteWeight_sum_one
  rw [finiteWeightSum, ← Nat.cast_sum,
    ← totalShell_card_eq_sum_multiplicity_of_necSuf HA HB U]
  exact_mod_cast hShell

/-- 具体版の実指数分布は、正の実重みの有限規格化である。 -/
theorem exponentialDistribution_eq_normalizedFiniteWeight
    (E : (VA → State) → ℝ) (beta : ℝ) (x : VA → State) :
    exponentialDistribution E beta x =
      normalizedFiniteWeight (fun z : VA → State => Real.exp (-beta * E z)) x := by
  rfl

/-- 具体版の指数分布の正値性は、正の有限重みの一般定理から得られる。 -/
theorem exponentialDistribution_pos_of_necSuf
    (E : (VA → State) → ℝ) (beta : ℝ) (x : VA → State) :
    0 < exponentialDistribution E beta x := by
  letI : Nonempty (VA → State) := ⟨fun _ => State.zero⟩
  rw [exponentialDistribution_eq_normalizedFiniteWeight]
  exact normalizedFiniteWeight_pos _ (fun z => Real.exp_pos _) x

/-- 正の台における具体版の比較は、点ごとの未規格化重みの一致から得られる。 -/
theorem countDistribution_eq_exponential_of_necSuf
    (HA : (VA → State) → ℤ) (HB : (VB → State) → ℤ) (U : ℤ)
    (hShell : (totalShell HA HB U).card ≠ 0)
    (hPositive : ∀ x : VA → State, 0 < secondMultiplicity HB (U - HA x))
    (x : VA → State) :
    (countDistribution HA HB U hShell x : ℝ) =
      exponentialDistribution (countEnergy HA HB U) 1 x := by
  rw [exponentialDistribution_eq_normalizedFiniteWeight]
  unfold normalizedFiniteWeight finiteWeightSum countDistribution
  simp only [neg_one_mul]
  rw [exp_neg_countEnergy HA HB U hPositive x]
  simp_rw [exp_neg_countEnergy HA HB U hPositive]
  rw [← Nat.cast_sum, ← totalShell_card_eq_sum_multiplicity_of_necSuf HA HB U]
  push_cast
  rfl

/-- 具体版の零重み反例は、正の有限重みの一般定理から得られる。 -/
theorem counterexample_not_exponential_of_necSuf
    (E : (Fin 1 → State) → ℝ) (beta : ℝ) :
    (countDistribution firstObservation secondObservation 0 counterexample_shell_nonzero
        oneConfiguration : ℝ) ≠ exponentialDistribution E beta oneConfiguration := by
  rw [counterexample_count_values.2]
  norm_num
  exact ne_of_lt (exponentialDistribution_pos_of_necSuf E beta oneConfiguration)

end Derivation

end

end CellularAutomata.NecSuf.FiniteBathCountCanonicalBoundary
