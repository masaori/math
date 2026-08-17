/-
章「臨界指数を零点列で書く」の「L ≥ 2 なら Fisher 零点集合は空でない」
（`claim_fisher_zero_set_nonempty`）の具体版。

人手証明と同じく、(0,0) のスピンだけを反転した配位を取り、最初の横辺が破れることから
正次数の係数が非零であることを示す。その係数から持ち上げた多項式の次数が零でないことを出し、
Qbar の代数閉性で根を取る。

住処: N と Qbar。R / C は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroFinsetCardBound
import Ising2DLambda.ThermodynamicLimit.IntegerPolynomialQbarLiftEvaluation

namespace Ising2DLambda.FisherZero

open Finset Polynomial
open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.ThermodynamicLimit

/-- スピン値 `+1`。 -/
def plusSpin : SpinValue := ⟨1, Or.inl rfl⟩

/-- スピン値 `-1`。 -/
def minusSpin : SpinValue := ⟨-1, Or.inr rfl⟩

theorem minusSpin_ne_plusSpin : minusSpin ≠ plusSpin := by
  intro h
  have hval := congrArg Subtype.val h
  norm_num [minusSpin, plusSpin] at hval

/-- 頂点 `(0,0)` だけが `-1` で、ほかが `+1` の配位。 -/
def singleFlippedConfig (L : ℕ) : Config L := fun v =>
  if v = ((0 : ZMod L), (0 : ZMod L)) then minusSpin else plusSpin

/-- `L ≥ 2` のとき、最初の横辺が存在する。 -/
def firstHorizontalEdge (L : ℕ) (hL : 2 ≤ L) : Edge L :=
  ⟨0, by positivity⟩

/-- 一つだけ反転した配位では、最初の横辺が破れている。 -/
theorem firstHorizontalEdge_broken (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    singleFlippedConfig L (boundary0 L (firstHorizontalEdge L hL)) ≠
      singleFlippedConfig L (boundary1 L (firstHorizontalEdge L hL)) := by
  have hL1 : 1 < L := by omega
  haveI : Fact (1 < L) := ⟨hL1⟩
  have hsq : 0 < L ^ 2 := by positivity
  have hb0 : boundary0 L (firstHorizontalEdge L hL) =
      ((0 : ZMod L), (0 : ZMod L)) := by
    simp [firstHorizontalEdge, boundary0, edgeRow, edgeColumn, edgeIndex]
  have hb1 : boundary1 L (firstHorizontalEdge L hL) =
      ((0 : ZMod L), (1 : ZMod L)) := by
    simp [firstHorizontalEdge, boundary1, edgeRow, edgeColumn, edgeIndex, hsq]
  have hvne : ((0 : ZMod L), (1 : ZMod L)) ≠ ((0 : ZMod L), (0 : ZMod L)) := by
    intro h
    have h' := congrArg Prod.snd h
    exact one_ne_zero h'
  rw [hb0, hb1]
  simp [singleFlippedConfig, minusSpin_ne_plusSpin]
  exact hvne

/-- 一つだけ反転した配位の破れボンド数は正である。 -/
theorem singleFlippedConfig_brokenBondCount_pos (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    0 < brokenBondCount L (singleFlippedConfig L) := by
  apply Finset.card_pos.mpr
  refine ⟨firstHorizontalEdge L hL, ?_⟩
  simp [firstHorizontalEdge_broken L hL]

/-- 正の破れボンド数を持つ配位があるので、その多重度は正である。 -/
theorem positive_multiplicity_exists (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    ∃ m : ℕ, 0 < m ∧ 0 < PartitionPolynomial.multiplicity L m := by
  let σ := singleFlippedConfig L
  let m := brokenBondCount L σ
  refine ⟨m, singleFlippedConfig_brokenBondCount_pos L hL, ?_⟩
  unfold PartitionPolynomial.multiplicity
  apply Finset.card_pos.mpr
  exact ⟨σ, by simp [m]⟩

/-- `L ≥ 2` なら有限格子の Fisher 零点集合は空でない。 -/
theorem fisherZeroSet_nonempty (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    (FisherZeroSet L).Nonempty := by
  obtain ⟨m, hmpos, hmultpos⟩ := positive_multiplicity_exists L hL
  let g := integerPolynomialQbarLift (partitionPolynomial L)
  have hmle : m ≤ 2 * L ^ 2 := by
    obtain ⟨σ, hσ⟩ := Finset.card_pos.mp hmultpos
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hσ
    rw [← hσ]
    exact brokenBondCount_le L σ
  have hcoeff : g.coeff m = (PartitionPolynomial.multiplicity L m : Qbar) := by
    simp only [g, integerPolynomialQbarLift_coeff, partitionPolynomial_coeff L m, if_pos hmle]
    norm_num
  have hcoeffne : g.coeff m ≠ 0 := by
    rw [hcoeff]
    exact_mod_cast (Nat.ne_of_gt hmultpos)
  have hdegree : g.degree ≠ 0 := by
    intro hzero
    have hlower : ((m : ℕ) : WithBot ℕ) ≤ g.degree := Polynomial.le_degree_of_ne_zero hcoeffne
    rw [hzero] at hlower
    have : m ≤ 0 := by exact_mod_cast hlower
    omega
  obtain ⟨xi, hxi⟩ := IsAlgClosed.exists_root g hdegree
  refine ⟨xi, ?_⟩
  rw [mem_fisherZero]
  rw [← qbarPolyEval_integerPolynomialQbarLift xi (partitionPolynomial L)]
  rw [qbarPolyEval_eq_eval]
  exact hxi

end Ising2DLambda.FisherZero
