/-
章「有限舞台上のブロック（分割）型更新」の Lean 必要十分版。

必要な構造の検査結果:
  - 一相更新とブロック内依存の特徴づけには、有限ブロック分割、任意の状態型、
    およびブロック入力を舞台全体へ延長するための既定状態一つだけを要する。
  - 二元状態、状態上の演算、対数、除算、全配位の極限、実数体、複素数体は要らない。
  - 舞台の有限性と等号判定は有限ブロック分割の表現に残る。
  - 状態型の有限性と等号判定は所属の有限決定にだけ要る。
-/
import CellularAutomata.BlockPartitionRuleClass

namespace CellularAutomata.NecSuf.BlockPartitionRuleClass

open CellularAutomata.BlockPartitionRuleClass

universe uA

noncomputable section

variable {V : Type} [Fintype V] [DecidableEq V]
variable {A : Type uA}

/-- 任意の状態型について、一つのブロックの入力から同じブロックの出力を返す規則族。 -/
abbrev LocalRuleFamily (P : BlockPartition V) (A : Type uA) :=
  (B : {B : Finset V // B ∈ P.blocks}) → (B.1 → A) → (B.1 → A)

/-- 任意の状態型について、配位を一つのブロックへ制限する。 -/
def restrictToBlock (x : V → A) (B : Finset V) : B → A :=
  fun v => x v.1

/-- 同じ分割の全ブロックを並行して更新する一般の一相更新。 -/
def phaseUpdate (P : BlockPartition V) (g : LocalRuleFamily P A) :
    (V → A) → (V → A) :=
  fun x v =>
    g ⟨membershipBlock P v, membershipBlock_mem P v⟩
      (restrictToBlock x (membershipBlock P v))
      ⟨v, self_mem_membershipBlock P v⟩

/-- 各ブロックの出力が同じブロックの入力だけに依存する一般条件。 -/
def BlockDependent (P : BlockPartition V) (H : (V → A) → (V → A)) : Prop :=
  ∀ (B : Finset V), B ∈ P.blocks → ∀ x y : V → A,
    (∀ v ∈ B, x v = y v) → ∀ v ∈ B, H x v = H y v

/-- 一相更新なら、各ブロックの出力は同じブロックの入力だけに依存する。 -/
theorem phaseUpdate_is_blockDependent (P : BlockPartition V) (g : LocalRuleFamily P A) :
    BlockDependent P (phaseUpdate P g) := by
  intro B hB x y hxy v hv
  have hmembership : membershipBlock P v = B := membershipBlock_eq_of_mem P hB hv
  unfold phaseUpdate
  have hrestricted : restrictToBlock x (membershipBlock P v) =
      restrictToBlock y (membershipBlock P v) := by
    funext w
    exact hxy w.1 (hmembership ▸ w.2)
  exact congrFun (congrArg (g ⟨membershipBlock P v, membershipBlock_mem P v⟩) hrestricted)
    ⟨v, self_mem_membershipBlock P v⟩

/-- ブロック入力を一つの既定状態で舞台全体へ延長する。 -/
def extendByDefault (default : A) (B : Finset V) (z : B → A) : V → A :=
  fun v => if hv : v ∈ B then z ⟨v, hv⟩ else default

/-- ブロック内依存条件から、既定状態による延長を使って規則族を復元する。 -/
def reconstructedFamily (default : A) (P : BlockPartition V)
    (H : (V → A) → (V → A)) : LocalRuleFamily P A :=
  fun B z v => H (extendByDefault default B.1 z) v.1

/-- ブロック内依存条件を満たす写像は、復元した一相更新に等しい。 -/
theorem phaseUpdate_reconstructed_eq (default : A) (P : BlockPartition V)
    (H : (V → A) → (V → A)) (hdependent : BlockDependent P H) :
    phaseUpdate P (reconstructedFamily default P H) = H := by
  funext x v
  let B := membershipBlock P v
  have hB : B ∈ P.blocks := membershipBlock_mem P v
  have hv : v ∈ B := self_mem_membershipBlock P v
  have hrestriction : ∀ w ∈ B,
      extendByDefault default B (restrictToBlock x B) w = x w := by
    intro w hw
    simp [extendByDefault, restrictToBlock, hw]
  exact hdependent B hB (extendByDefault default B (restrictToBlock x B)) x
    hrestriction v hv

/-- 一相ブロック更新は、ブロック内入力だけへの依存で特徴づけられる。 -/
theorem phaseUpdate_iff_blockDependent (default : A) (P : BlockPartition V)
    (H : (V → A) → (V → A)) :
    (∃ g : LocalRuleFamily P A, H = phaseUpdate P g) ↔ BlockDependent P H := by
  constructor
  · rintro ⟨g, rfl⟩
    exact phaseUpdate_is_blockDependent P g
  · intro hdependent
    exact ⟨reconstructedFamily default P H,
      (phaseUpdate_reconstructed_eq default P H hdependent).symm⟩

section FiniteDecision

variable [Fintype A] [DecidableEq A]

/-- 有限状態型では、全ブロック・全入力対・全出力点の依存条件を有限決定できる。 -/
instance blockDependentDecidable (P : BlockPartition V) (H : (V → A) → (V → A)) :
    Decidable (BlockDependent P H) := by
  unfold BlockDependent
  infer_instance

/-- 既定状態を一つ与えれば、一相更新への所属も依存条件を通じて有限決定できる。 -/
def phaseUpdateMembershipDecidable (default : A) (P : BlockPartition V)
    (H : (V → A) → (V → A)) :
    Decidable (∃ g : LocalRuleFamily P A, H = phaseUpdate P g) :=
  decidable_of_iff (BlockDependent P H) (phaseUpdate_iff_blockDependent default P H).symm

end FiniteDecision

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency

/-- 具体版の一相更新から依存条件への向きは、任意の状態型に対する一般主張の特殊化である。 -/
theorem phaseUpdate_is_blockDependent_of_necSuf
    (P : BlockPartition V)
    (g : CellularAutomata.BlockPartitionRuleClass.LocalRuleFamily P) :
    CellularAutomata.BlockPartitionRuleClass.BlockDependent P
      (CellularAutomata.BlockPartitionRuleClass.phaseUpdate P g) := by
  exact phaseUpdate_is_blockDependent (A := State) P g

/-- 具体版の復元等式は、既定状態を零とした一般主張の特殊化である。 -/
theorem phaseUpdate_reconstructed_eq_of_necSuf
    (P : BlockPartition V) (H : (V → State) → (V → State))
    (hdependent : CellularAutomata.BlockPartitionRuleClass.BlockDependent P H) :
    CellularAutomata.BlockPartitionRuleClass.phaseUpdate P
      (CellularAutomata.BlockPartitionRuleClass.reconstructedFamily P H) = H := by
  exact phaseUpdate_reconstructed_eq State.zero P H hdependent

/-- 具体版の特徴づけは、任意の状態型と既定状態に対する一般同値の特殊化である。 -/
theorem phaseUpdate_iff_blockDependent_of_necSuf
    (P : BlockPartition V) (H : (V → State) → (V → State)) :
    (∃ g : CellularAutomata.BlockPartitionRuleClass.LocalRuleFamily P,
      H = CellularAutomata.BlockPartitionRuleClass.phaseUpdate P g) ↔
      CellularAutomata.BlockPartitionRuleClass.BlockDependent P H := by
  exact phaseUpdate_iff_blockDependent State.zero P H

/-- 具体版の有限所属判定は、有限状態型上の一般決定の特殊化である。 -/
theorem phaseUpdate_finite_decidable_of_necSuf
    (P : BlockPartition V) (H : (V → State) → (V → State)) :
    (∃ g : CellularAutomata.BlockPartitionRuleClass.LocalRuleFamily P,
      H = CellularAutomata.BlockPartitionRuleClass.phaseUpdate P g) ∨
      ¬ ∃ g : CellularAutomata.BlockPartitionRuleClass.LocalRuleFamily P,
        H = CellularAutomata.BlockPartitionRuleClass.phaseUpdate P g := by
  exact @Decidable.em _ (phaseUpdateMembershipDecidable State.zero P H)

end Derivation

end
end CellularAutomata.NecSuf.BlockPartitionRuleClass
