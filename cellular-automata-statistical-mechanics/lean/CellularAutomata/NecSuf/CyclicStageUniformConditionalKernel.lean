/-
章「有限窓内の一様条件付き再標本化核と有限固定点等式」の
Lean 必要十分版。

必要な構造の検査結果:
  - 状態型 P の有限性と、各関係繊維の元数が同じ正の自然数 n であることだけで
    一様核の行正規化が従う。
  - 列正規化には関係の対称性だけを追加で要する。
  - 一様重みの不変性には、その重みが状態によらず一定であることだけを要する。
  - 二元状態、巡回舞台、窓、局所規則、時間発展、順序、対数、極限、
    Gibbs 仕様、実数体、複素数体は要らない。

具体版と同じく、関係繊維を数えて行和を求め、対称性で列和へ移し、
一定重みを有限和の外へ出して固定点等式を得る。
-/
import CellularAutomata.CyclicStageUniformConditionalKernel
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.FieldSimp

namespace CellularAutomata.NecSuf.CyclicStageUniformConditionalKernel

open scoped BigOperators

variable {P : Type}

noncomputable section

/-- 有限型上の関係繊維を一様に選ぶ有理核。 -/
def uniformRelationKernel (relation : P → P → Prop) [DecidableRel relation]
    (fiberCard : ℕ) (source target : P) : ℚ :=
  if relation source target then 1 / fiberCard else 0

section FiniteRelation

variable [Fintype P]

/-- 各関係繊維が同じ正の元数を持てば、一様関係核の各行は一に和を取る。 -/
theorem uniformRelationKernel_normalized
    (relation : P → P → Prop) [DecidableRel relation]
    (fiberCard : ℕ) (hpositive : 0 < fiberCard)
    (hcard : ∀ source : P,
      (Finset.univ.filter fun target : P => relation source target).card = fiberCard)
    (source : P) :
    ∑ target : P, uniformRelationKernel relation fiberCard source target = 1 := by
  classical
  simp only [uniformRelationKernel]
  rw [← Finset.sum_filter]
  simp only [Finset.sum_const, nsmul_eq_mul]
  rw [hcard source]
  field_simp

/-- 対称な関係では、一様関係核の列和も一に等しい。 -/
theorem uniformRelationKernel_column_normalized
    (relation : P → P → Prop) [DecidableRel relation]
    (fiberCard : ℕ) (hpositive : 0 < fiberCard)
    (hcard : ∀ source : P,
      (Finset.univ.filter fun target : P => relation source target).card = fiberCard)
    (hsymmetric : ∀ source target : P, relation source target ↔ relation target source)
    (target : P) :
    ∑ source : P, uniformRelationKernel relation fiberCard source target = 1 := by
  classical
  calc
    (∑ source : P, uniformRelationKernel relation fiberCard source target) =
        ∑ source : P, uniformRelationKernel relation fiberCard target source := by
      apply Finset.sum_congr rfl
      intro source _hsource
      by_cases h : relation source target
      · have h' : relation target source := (hsymmetric source target).mp h
        simp [uniformRelationKernel, h, h']
      · have h' : ¬ relation target source := by
          intro htarget
          exact h ((hsymmetric source target).mpr htarget)
        simp [uniformRelationKernel, h, h']
    _ = 1 := uniformRelationKernel_normalized relation fiberCard hpositive hcard target

/-- 一定な有限重みは、対称な一様関係核の作用で不変である。 -/
theorem constantWeight_uniformRelationKernel_invariant
    (relation : P → P → Prop) [DecidableRel relation]
    (fiberCard : ℕ) (hpositive : 0 < fiberCard)
    (hcard : ∀ source : P,
      (Finset.univ.filter fun target : P => relation source target).card = fiberCard)
    (hsymmetric : ∀ source target : P, relation source target ↔ relation target source)
    (weight : ℚ) (target : P) :
    ∑ source : P, weight * uniformRelationKernel relation fiberCard source target = weight := by
  rw [← Finset.mul_sum]
  rw [uniformRelationKernel_column_normalized relation fiberCard hpositive hcard hsymmetric target]
  exact mul_one weight

end FiniteRelation

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageUniformConditionalKernel
open CellularAutomata.CyclicStageUniformMarginals
open CellularAutomata.EssentialDependency

/-- 具体版の条件付き再標本化核は、一様関係核の特殊化である。 -/
theorem concreteConditionalKernel_eq_necessary_sufficient (m s : ℕ) :
    conditionalKernel m s =
      uniformRelationKernel (outsideAgrees m s) (2 ^ (2 * s + 1)) := by
  classical
  funext source target
  simp [conditionalKernel, uniformRelationKernel]

/-- 具体版の行正規化は、等濃度な関係繊維の有限個数から導かれる。 -/
theorem conditionalKernel_normalized_of_necSuf (m s : ℕ) (hsm : s ≤ m)
    (source : OddStage m → State) :
    ∑ target : OddStage m → State, conditionalKernel m s source target = 1 := by
  rw [concreteConditionalKernel_eq_necessary_sufficient]
  exact uniformRelationKernel_normalized (outsideAgrees m s) (2 ^ (2 * s + 1))
    (by positivity) (fun x => outsideAgrees_filter_card m s hsm x) source

/-- 具体版の一様重み固定点等式は、対称な等濃度関係核の一般定理から導かれる。 -/
theorem uniformWeight_conditionalKernel_invariant_of_necSuf
    (m s : ℕ) (hsm : s ≤ m) (target : OddStage m → State) :
    ∑ source : OddStage m → State,
        uniformWeight m source * conditionalKernel m s source target = uniformWeight m target := by
  simp only [CellularAutomata.CyclicStageUniformMarginals.uniformWeight]
  rw [concreteConditionalKernel_eq_necessary_sufficient]
  exact constantWeight_uniformRelationKernel_invariant
    (outsideAgrees m s) (2 ^ (2 * s + 1)) (by positivity)
    (fun x => outsideAgrees_filter_card m s hsm x)
    (fun x y => outsideAgrees_comm m s x y)
    (1 / (2 ^ (2 * m + 1) : ℕ)) target

end Derivation

end

end CellularAutomata.NecSuf.CyclicStageUniformConditionalKernel
