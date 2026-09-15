/-
正本: content/finite-gibbs-weight-boundary.ts の必要十分版。

必要な構造の検査結果:
  - 正の有限行分配和と規格化には、有限で空でない状態型と線形順序体値の正の重みだけを要る。
  - 零重みと正の規格化重みの非一致には、順序と零だけを要る。
  - 二元状態、有理遷移重み、実指数関数、エネルギー、逆温度、局所規則、時間発展、
    対数、無限舞台、極限、完備化、無限 Gibbs 仕様、複素数体は一般定理では使わない。

具体版と同じく、正の有限和が正であることを示し、その和で各項を割って
正値性と行和一を得た後、零と正値の非一致を使う。
-/
import CellularAutomata.FiniteGibbsWeightBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteGibbsWeightBoundary

open scoped BigOperators

noncomputable section

variable {X W : Type}

/-! ## 有限集合上の正の重みの規格化 -/

/-- 有限状態型上の一行の重みの有限和。 -/
def rowWeightSum [Fintype X] [AddCommMonoid W]
    (weight : X → X → W) (source : X) : W :=
  ∑ target : X, weight source target

/-- 空でない有限状態型上で各重みが正なら、その有限和も正である。 -/
theorem rowWeightSum_pos [Fintype X] [Nonempty X]
    [Field W] [LinearOrder W] [IsStrictOrderedRing W]
    (weight : X → X → W) (hpositive : ∀ source target, 0 < weight source target)
    (source : X) :
    0 < rowWeightSum weight source := by
  classical
  unfold rowWeightSum
  positivity

/-- 正の有限行和で割った規格化重み。 -/
def normalizedWeight [Fintype X] [Field W]
    (weight : X → X → W) (source target : X) : W :=
  weight source target / rowWeightSum weight source

/-- 正の重みを正の有限行和で割った規格化重みは正である。 -/
theorem normalizedWeight_pos [Fintype X] [Nonempty X]
    [Field W] [LinearOrder W] [IsStrictOrderedRing W]
    (weight : X → X → W) (hpositive : ∀ source target, 0 < weight source target)
    (source target : X) :
    0 < normalizedWeight weight source target := by
  exact div_pos (hpositive source target) (rowWeightSum_pos weight hpositive source)

/-- 正の重みを有限行和で割った規格化重みは各行で一に和を取る。 -/
theorem normalizedWeight_row_sum [Fintype X] [Nonempty X]
    [Field W] [LinearOrder W] [IsStrictOrderedRing W]
    (weight : X → X → W) (hpositive : ∀ source target, 0 < weight source target)
    (source : X) :
    ∑ target : X, normalizedWeight weight source target = 1 := by
  classical
  rw [show (∑ target : X, normalizedWeight weight source target) =
      (∑ target : X, weight source target) / rowWeightSum weight source by
        simp only [normalizedWeight, Finset.sum_div]]
  rw [show (∑ target : X, weight source target) = rowWeightSum weight source by
    rfl]
  exact div_self (ne_of_gt (rowWeightSum_pos weight hpositive source))

/-! ## 零重みと正の重みの非一致 -/

/-- 順序と零を持つ値域では、零は任意の正の重みと異なる。 -/
theorem zero_ne_positive [Preorder W] [Zero W]
    (positiveWeight : W) (hpositive : 0 < positiveWeight) :
    0 ≠ positiveWeight :=
  ne_of_lt hpositive

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FiniteGibbsWeightBoundary

/-- 具体版の行分配和は、正の有限重みの行和の特殊化である。 -/
theorem rowPartitionSum_eq_necessary_sufficient {X : Type*} [Fintype X]
    (E : X → X → ℝ) (beta : ℝ) (source : X) :
    rowPartitionSum E beta source =
      rowWeightSum (fun x y => Real.exp (-beta * E x y)) source := by
  rfl

/-- 具体版の Gibbs 遷移重みは、正の有限重みの規格化の特殊化である。 -/
theorem gibbsTransitionWeight_eq_necessary_sufficient {X : Type*} [Fintype X]
    (E : X → X → ℝ) (beta : ℝ) (source target : X) :
    gibbsTransitionWeight E beta source target =
      normalizedWeight (fun x y => Real.exp (-beta * E x y)) source target := by
  rfl

/-- 具体版の行分配和の正値性は、正の有限重みの一般定理から得られる。 -/
theorem rowPartitionSum_pos_of_necSuf {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (source : X) :
    0 < rowPartitionSum E beta source := by
  rw [rowPartitionSum_eq_necessary_sufficient]
  exact rowWeightSum_pos _ (fun x y => Real.exp_pos _) source

/-- 具体版の Gibbs 重みの正値性は、正の有限重みの一般定理から得られる。 -/
theorem gibbsTransitionWeight_pos_of_necSuf {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (_hBeta : 0 < beta) (source target : X) :
    0 < gibbsTransitionWeight E beta source target := by
  rw [gibbsTransitionWeight_eq_necessary_sufficient]
  exact normalizedWeight_pos _ (fun x y => Real.exp_pos _) source target

/-- 具体版の行規格化は、正の有限重みの一般定理から得られる。 -/
theorem gibbsTransitionWeight_row_sum_of_necSuf
    {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (_hBeta : 0 < beta) (source : X) :
    ∑ target : X, gibbsTransitionWeight E beta source target = 1 := by
  simp_rw [gibbsTransitionWeight_eq_necessary_sufficient]
  exact normalizedWeight_row_sum _ (fun x y => Real.exp_pos _) source

/-- 一セル恒等規則の零重み反例は、零と正値の一般の非一致から得られる。 -/
theorem identityRationalTransitionWeight_notFiniteGibbs_of_necSuf
    (E : Bool → Bool → ℝ) (beta : ℝ) (hBeta : 0 < beta) :
    rationalRealComparison identityRationalTransitionWeight false true = 0 ∧
      rationalRealComparison identityRationalTransitionWeight false true ≠
        gibbsTransitionWeight E beta false true := by
  constructor
  · norm_num [rationalRealComparison, identityRationalTransitionWeight]
  · rw [show rationalRealComparison identityRationalTransitionWeight false true = 0 by
      norm_num [rationalRealComparison, identityRationalTransitionWeight]]
    exact zero_ne_positive _
      (gibbsTransitionWeight_pos_of_necSuf E beta hBeta false true)

end Derivation

end

end CellularAutomata.NecSuf.FiniteGibbsWeightBoundary
