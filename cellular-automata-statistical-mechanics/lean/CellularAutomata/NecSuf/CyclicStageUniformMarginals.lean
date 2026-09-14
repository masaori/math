/-
章「奇数位数の有限巡回舞台上の一様有理分布と周辺化整合性」の
再周辺化等式に対する Lean 必要十分版。

必要な構造の検査結果:
  - 元の重みを足す舞台配位型 P と、大窓観測型 R の有限性だけを要する。
  - 小窓観測型 Q の有限性、二元状態、巡回舞台、窓の半径、単射、一様分布は要らない。
  - 重みの値域 W には零元、加法、有限和の順序交換だけを要する。
  - 大窓観測を小窓へ送る写像と、舞台からの二つの観測写像が可換することだけを仮定する。
  - 有理数の乗法・除算・順序、対数、極限、Gibbs 仕様、実数体、複素数体は要らない。

具体版と同じく、二重有限和を交換し、各舞台配位について唯一の大窓観測だけを残し、
観測写像の可換性で小窓条件へ戻す。
-/
import CellularAutomata.CyclicStageUniformMarginals
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace CellularAutomata.NecSuf.CyclicStageUniformMarginals

open scoped BigOperators

variable {P Q R W : Type}

section Remarginalization

variable [Fintype P] [Fintype R] [DecidableEq Q] [DecidableEq R] [AddCommMonoid W]

/-- 有限型 P 上の重みを観測写像の繊維ごとに足した周辺重み。 -/
def marginalWeight (weight : P → W) (observation : P → Q) (a : Q) : W :=
  ∑ x : P, if observation x = a then weight x else 0

/--
大窓観測から小窓観測への写像が二つの観測写像と可換すれば、
大窓周辺重みの再周辺化は小窓周辺重みに一致する。
-/
theorem marginalWeight_consistent
    (weight : P → W) (largeObservation : P → R) (smallObservation : P → Q)
    (restriction : R → Q)
    (hcompatible : ∀ x : P, restriction (largeObservation x) = smallObservation x)
    (a : Q) :
    marginalWeight weight smallObservation a =
      ∑ c : R, if restriction c = a then marginalWeight weight largeObservation c else 0 := by
  classical
  unfold marginalWeight
  symm
  calc
    (∑ c : R,
        if restriction c = a then
          ∑ x : P, if largeObservation x = c then weight x else 0
        else 0) =
        ∑ c : R, ∑ x : P,
          if restriction c = a then
            (if largeObservation x = c then weight x else 0)
          else 0 := by
      apply Finset.sum_congr rfl
      intro c _hc
      rw [Finset.sum_ite_irrel]
      simp
    _ = ∑ x : P, ∑ c : R,
          if restriction c = a then
            (if largeObservation x = c then weight x else 0)
          else 0 := by
      rw [Finset.sum_comm]
    _ = ∑ x : P, if smallObservation x = a then weight x else 0 := by
      apply Finset.sum_congr rfl
      intro x _hx
      have hsingle :
          (∑ c : R,
            if restriction c = a then
              (if largeObservation x = c then weight x else 0)
            else 0) =
            if restriction (largeObservation x) = a then weight x else 0 := by
        rw [Finset.sum_eq_single (largeObservation x)]
        · simp
        · intro c _hc hne
          have hne' : largeObservation x ≠ c := Ne.symm hne
          simp [hne']
        · simp
      rw [hsingle, hcompatible x]

end Remarginalization

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.CyclicStageUniformMarginals
open CellularAutomata.EssentialDependency

/-- 具体版の周辺重みは、有限型上の繊維和の特殊化である。 -/
theorem concreteMarginalWeight_eq_necessary_sufficient
    (m s : ℕ) (a : Offset s → State) :
    CellularAutomata.CyclicStageUniformMarginals.marginalWeight m s a =
      marginalWeight
        (CellularAutomata.CyclicStageUniformMarginals.uniformWeight m)
        (CellularAutomata.CyclicStageUniformMarginals.windowPullback m s) a := by
  classical
  unfold CellularAutomata.CyclicStageUniformMarginals.marginalWeight marginalWeight
  rfl

/-- 具体版の再周辺化等式は、有限和と観測写像の可換性だけを使う一般定理の特殊化である。 -/
theorem marginalWeight_consistent_of_necSuf
    (m s t : ℕ) (hst : s ≤ t) (_htm : t ≤ m) (a : Offset s → State) :
    CellularAutomata.CyclicStageUniformMarginals.marginalWeight m s a =
      ∑ c : Offset t → State,
        if restrictWindow s t hst c = a then
          CellularAutomata.CyclicStageUniformMarginals.marginalWeight m t c
        else 0 := by
  rw [concreteMarginalWeight_eq_necessary_sufficient]
  simp_rw [concreteMarginalWeight_eq_necessary_sufficient]
  exact marginalWeight_consistent
    (weight := CellularAutomata.CyclicStageUniformMarginals.uniformWeight m)
    (largeObservation := CellularAutomata.CyclicStageUniformMarginals.windowPullback m t)
    (smallObservation := CellularAutomata.CyclicStageUniformMarginals.windowPullback m s)
    (restriction := restrictWindow s t hst)
    (fun x => windowPullback_compatible m s t hst x) a

end Derivation

end CellularAutomata.NecSuf.CyclicStageUniformMarginals
