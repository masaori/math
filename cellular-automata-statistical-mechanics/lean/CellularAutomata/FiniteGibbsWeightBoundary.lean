/-
正本: content/finite-gibbs-weight-boundary.ts の具体版。

def_rational_transition_real_comparison
  → rationalRealComparison
def_finite_real_row_partition_sum
  → rowPartitionSum
def_finite_gibbs_transition_weight
  → gibbsTransitionWeight
claim_finite_gibbs_transition_weight_strictly_positive
  → gibbsTransitionWeight_pos
claim_finite_gibbs_transition_weight_normalized
  → gibbsTransitionWeight_row_sum
def_single_cell_identity_rational_transition_weight
  → identityRationalTransitionWeight
claim_rational_transition_weight_not_always_finite_gibbs
  → identityRationalTransitionWeight_notFiniteGibbs

有限配位型、有限実数値エネルギー、正の実数値逆温度に固定し、
本文と同じ順序で示す。対数、無限舞台、極限、完備化、無限 Gibbs 仕様は使わない。
-/
import Mathlib

namespace CellularAutomata.FiniteGibbsWeightBoundary

noncomputable section

/-! ## 有限有理遷移重みの標準実数比較 -/

/-- 有理遷移重みの値を標準単射 `ℚ → ℝ` で送る。 -/
def rationalRealComparison {X : Type*} (K : X → X → ℚ) (x y : X) : ℝ :=
  K x y

/-- 標準実数比較は有理数の零を実数の零へ送る。 -/
theorem rationalRealComparison_zero {X : Type*} (x y : X) :
    rationalRealComparison (fun _ _ : X => (0 : ℚ)) x y = 0 := by
  norm_num [rationalRealComparison]

/-! ## 有限実数値エネルギーの行分配和 -/

/-- 有限配位型上の有限行分配和。 -/
def rowPartitionSum {X : Type*} [Fintype X]
    (E : X → X → ℝ) (beta : ℝ) (x : X) : ℝ :=
  ∑ z : X, Real.exp (-beta * E x z)

/-- 非空な有限配位型の行分配和は正である。 -/
theorem rowPartitionSum_pos {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (x : X) :
    0 < rowPartitionSum E beta x := by
  classical
  unfold rowPartitionSum
  positivity

/-! ## 有限 Gibbs 遷移重み -/

/-- 有限行分配和で規格化した Gibbs 遷移重み。 -/
def gibbsTransitionWeight {X : Type*} [Fintype X]
    (E : X → X → ℝ) (beta : ℝ) (x y : X) : ℝ :=
  Real.exp (-beta * E x y) / rowPartitionSum E beta x

/-- 有限 Gibbs 遷移重みは全て正である。 -/
theorem gibbsTransitionWeight_pos {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (_hBeta : 0 < beta) (x y : X) :
    0 < gibbsTransitionWeight E beta x y := by
  exact div_pos (Real.exp_pos _) (rowPartitionSum_pos E beta x)

/-- 有限 Gibbs 遷移重みは各行で一に規格化される。 -/
theorem gibbsTransitionWeight_row_sum {X : Type*} [Fintype X] [Nonempty X]
    (E : X → X → ℝ) (beta : ℝ) (_hBeta : 0 < beta) (x : X) :
    ∑ y : X, gibbsTransitionWeight E beta x y = 1 := by
  classical
  rw [show (∑ y : X, gibbsTransitionWeight E beta x y) =
      (∑ y : X, Real.exp (-beta * E x y)) / rowPartitionSum E beta x by
        simp only [gibbsTransitionWeight, Finset.sum_div]]
  rw [show (∑ y : X, Real.exp (-beta * E x y)) = rowPartitionSum E beta x by
    rfl]
  exact div_self (ne_of_gt (rowPartitionSum_pos E beta x))

/-! ## 一セル恒等規則の有限反例 -/

/-- 一セル恒等規則が二配位上に定める有理零一遷移重み。 -/
def identityRationalTransitionWeight (x y : Bool) : ℚ :=
  if x = y then 1 else 0

/-- 一セル恒等規則の非対角遷移重みは零である。 -/
theorem identityRationalTransitionWeight_false_true :
    identityRationalTransitionWeight false true = 0 := by
  decide

/--
一セル恒等規則の非対角有理零重みの実数像は、
任意の有限実数値エネルギーと正の逆温度から作る Gibbs 重みと一致しない。
-/
theorem identityRationalTransitionWeight_notFiniteGibbs
    (E : Bool → Bool → ℝ) (beta : ℝ) (hBeta : 0 < beta) :
    rationalRealComparison identityRationalTransitionWeight false true = 0 ∧
      rationalRealComparison identityRationalTransitionWeight false true ≠
        gibbsTransitionWeight E beta false true := by
  constructor
  · norm_num [rationalRealComparison, identityRationalTransitionWeight]
  · have hPositive : 0 < gibbsTransitionWeight E beta false true :=
      gibbsTransitionWeight_pos E beta hBeta false true
    norm_num [rationalRealComparison, identityRationalTransitionWeight]
    exact ne_of_lt hPositive

end

end CellularAutomata.FiniteGibbsWeightBoundary
