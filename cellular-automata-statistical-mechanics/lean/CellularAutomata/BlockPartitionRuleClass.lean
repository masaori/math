/-
正本: structured-latex/content/block-partition-rule-class.ts の具体版。

有限舞台、演算を持たない二元状態、有限ブロック分割を固定し、所属ブロック、
ブロック局所規則族、一相更新、ブロック内入力だけへの依存による特徴づけ、
有限所属判定、および同期二セル交換との境界を、人手証明と同じ順序で形式化する。

有限型・有限集合・有限写像だけを使う。対数、除算、全配位の極限、
実数体、複素数体は使わない。
-/
import CellularAutomata.TimeExpansionDependency

namespace CellularAutomata.BlockPartitionRuleClass

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency

noncomputable section

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 空でないブロックが舞台の各元を重複なく覆う有限ブロック分割。 -/
structure BlockPartition (V : Type) [Fintype V] [DecidableEq V] where
  blocks : Finset (Finset V)
  nonempty : ∀ B ∈ blocks, B.Nonempty
  uniqueBlock : ∀ v : V, ∃! B : Finset V, B ∈ blocks ∧ v ∈ B

/-- 各舞台元が属する唯一のブロック。 -/
def membershipBlock (P : BlockPartition V) (v : V) : Finset V :=
  Classical.choose (P.uniqueBlock v)

/-- 所属ブロックは分割の元である。 -/
theorem membershipBlock_mem (P : BlockPartition V) (v : V) :
    membershipBlock P v ∈ P.blocks :=
  (Classical.choose_spec (P.uniqueBlock v)).1.1

/-- 各舞台元は自身の所属ブロックに属する。 -/
theorem self_mem_membershipBlock (P : BlockPartition V) (v : V) :
    v ∈ membershipBlock P v :=
  (Classical.choose_spec (P.uniqueBlock v)).1.2

/-- あるブロックに属する元の所属ブロックは、そのブロック自身である。 -/
theorem membershipBlock_eq_of_mem (P : BlockPartition V) {B : Finset V}
    (hB : B ∈ P.blocks) {v : V} (hv : v ∈ B) : membershipBlock P v = B := by
  exact ((Classical.choose_spec (P.uniqueBlock v)).2 B ⟨hB, hv⟩).symm

/-- 各ブロックは所属ブロック写像の対応する繊維として復元される。 -/
theorem membershipFiber_eq (P : BlockPartition V) {B : Finset V} (hB : B ∈ P.blocks) :
    {v : V | membershipBlock P v = B} = (B : Set V) := by
  ext v
  constructor
  · intro hv
    rw [← hv]
    exact self_mem_membershipBlock P v
  · intro hv
    exact membershipBlock_eq_of_mem P hB hv

/-- 一つのブロックの入力だけから同じブロックの出力を返す局所規則族。 -/
abbrev LocalRuleFamily (P : BlockPartition V) :=
  (B : {B : Finset V // B ∈ P.blocks}) → (↥B.1 → State) → (↥B.1 → State)

/-- ブロック上への配位の制限。 -/
def restrictToBlock (x : V → State) (B : Finset V) : ↥B → State :=
  fun v => x v.1

/-- 同じ分割の全ブロックを並行して更新する一相更新。 -/
def phaseUpdate (P : BlockPartition V) (g : LocalRuleFamily P) :
    (V → State) → (V → State) :=
  fun x v =>
    g ⟨membershipBlock P v, membershipBlock_mem P v⟩
      (restrictToBlock x (membershipBlock P v))
      ⟨v, self_mem_membershipBlock P v⟩

/-- 一つの分割と、その分割上の局所規則族からなる一相。 -/
abbrev Phase (V : Type) [Fintype V] [DecidableEq V] :=
  Σ P : BlockPartition V, LocalRuleFamily P

/-- 正個の相を順序づけた有限ブロックスケジュール。 -/
structure FiniteBlockSchedule (V : Type) [Fintype V] [DecidableEq V] where
  phaseCount : ℕ
  positive : 0 < phaseCount
  phases : Fin phaseCount → Phase V

/-- 先頭から `n` 個の相を指定順に施す。 -/
def applyPhasePrefix (schedule : FiniteBlockSchedule V) :
    (n : ℕ) → n ≤ schedule.phaseCount → (V → State) → (V → State)
  | 0, _, x => x
  | n + 1, hn, x =>
      let preceding := applyPhasePrefix schedule n (Nat.le_trans (Nat.le_succ n) hn) x
      let phase := schedule.phases ⟨n, hn⟩
      phaseUpdate phase.1 phase.2 preceding

/-- 有限スケジュールの全相を指定順に合成した一巡更新。 -/
def sweepUpdate (schedule : FiniteBlockSchedule V) : (V → State) → (V → State) :=
  applyPhasePrefix schedule schedule.phaseCount (Nat.le_refl _)

/-- 各ブロックの出力が同じブロックの入力だけに依存するという条件。 -/
def BlockDependent (P : BlockPartition V) (H : (V → State) → (V → State)) : Prop :=
  ∀ (B : Finset V), B ∈ P.blocks → ∀ x y : V → State,
    (∀ v ∈ B, x v = y v) → ∀ v ∈ B, H x v = H y v

/-- 一相更新なら、各ブロックの出力は同じブロックの入力だけに依存する。 -/
theorem phaseUpdate_is_blockDependent (P : BlockPartition V) (g : LocalRuleFamily P) :
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

/-- ブロック上の入力を零で舞台全体へ延長する。 -/
def extendByZero (B : Finset V) (z : ↥B → State) : V → State :=
  fun v => if hv : v ∈ B then z ⟨v, hv⟩ else State.zero

/-- ブロック内入力だけへの依存から零延長で局所規則族を復元する。 -/
def reconstructedFamily (P : BlockPartition V) (H : (V → State) → (V → State)) :
    LocalRuleFamily P :=
  fun B z v => H (extendByZero B.1 z) v.1

/-- ブロック内入力だけへの依存を満たす写像は、復元した一相更新に等しい。 -/
theorem phaseUpdate_reconstructed_eq (P : BlockPartition V)
    (H : (V → State) → (V → State)) (hdependent : BlockDependent P H) :
    phaseUpdate P (reconstructedFamily P H) = H := by
  funext x v
  let B := membershipBlock P v
  have hB : B ∈ P.blocks := membershipBlock_mem P v
  have hv : v ∈ B := self_mem_membershipBlock P v
  have hrestriction : ∀ w ∈ B,
      extendByZero B (restrictToBlock x B) w = x w := by
    intro w hw
    simp [extendByZero, restrictToBlock, hw]
  have heq := hdependent B hB (extendByZero B (restrictToBlock x B)) x hrestriction v hv
  exact heq

/-- 一相ブロック更新は、ブロック内入力だけへの依存で特徴づけられる。 -/
theorem phaseUpdate_iff_blockDependent (P : BlockPartition V)
    (H : (V → State) → (V → State)) :
    (∃ g : LocalRuleFamily P, H = phaseUpdate P g) ↔ BlockDependent P H := by
  constructor
  · rintro ⟨g, rfl⟩
    exact phaseUpdate_is_blockDependent P g
  · intro hdependent
    exact ⟨reconstructedFamily P H, (phaseUpdate_reconstructed_eq P H hdependent).symm⟩

/-- 全ブロック・全入力対・全出力セルを有限走査して依存条件を決定できる。 -/
instance blockDependentDecidable (P : BlockPartition V) (H : (V → State) → (V → State)) :
    Decidable (BlockDependent P H) := by
  unfold BlockDependent
  infer_instance

/-- 特徴づけを通じて、固定分割に対する一相更新への所属を有限決定できる。 -/
instance phaseUpdateMembershipDecidable (P : BlockPartition V)
    (H : (V → State) → (V → State)) :
    Decidable (∃ g : LocalRuleFamily P, H = phaseUpdate P g) :=
  decidable_of_iff (BlockDependent P H) (phaseUpdate_iff_blockDependent P H).symm

/-- 有限舞台の各元を一つずつ分ける一元ブロック分割。 -/
def singletonPartition (V : Type) [Fintype V] [DecidableEq V] : BlockPartition V where
  blocks := Finset.univ.image fun v => {v}
  nonempty := by simp
  uniqueBlock := by
    intro v
    refine ⟨{v}, by simp, ?_⟩
    intro B hB
    rcases Finset.mem_image.mp hB.1 with ⟨w, _, rfl⟩
    have hvw : v = w := by simpa using hB.2
    subst w
    rfl

/-- 二セルの状態を交換する同期写像。 -/
def swapMap (x : Fin 2 → State) : Fin 2 → State :=
  fun v => x (if v = 0 then 1 else 0)

/-- 二セル交換を同期局所更新として与える全近傍。 -/
def swapNeighborhood (_ : Fin 2) : Finset (Fin 2) := Finset.univ

/-- 各セルが他方のセルの状態を読む、二セル交換の局所規則。 -/
def swapLocalRule (v : Fin 2) (x : ↥(swapNeighborhood v) → State) : State :=
  x ⟨if v = 0 then 1 else 0, by simp [swapNeighborhood]⟩

/-- 二セル交換は有限真理値表から作る同期局所更新そのものである。 -/
theorem swapGlobalMap_eq_swapMap :
    globalMap swapNeighborhood swapLocalRule = swapMap := by
  rfl

/-- 二セル交換は一元ブロック分割へのブロック内依存条件を破る。 -/
theorem swapMap_not_blockDependent :
    ¬ BlockDependent (singletonPartition (Fin 2)) swapMap := by
  intro hdependent
  let x : Fin 2 → State := fun _ => State.zero
  let y : Fin 2 → State := fun v => if v = 0 then State.zero else State.one
  have hsame : ∀ w ∈ ({0} : Finset (Fin 2)), x w = y w := by
    intro w hw
    have hw0 : w = 0 := by simpa using hw
    subst w
    rfl
  have heq := hdependent {0} (by simp [singletonPartition]) x y hsame 0 (by simp)
  change State.zero = State.one at heq
  exact State.noConfusion heq

/-- 同期局所更新である二セル交換は、指定した一元ブロック分割の一相更新ではない。 -/
theorem swapMap_not_phaseUpdate :
    ¬ ∃ g : LocalRuleFamily (singletonPartition (Fin 2)),
      swapMap = phaseUpdate (singletonPartition (Fin 2)) g := by
  intro hrepresentation
  exact swapMap_not_blockDependent
    ((phaseUpdate_iff_blockDependent (singletonPartition (Fin 2)) swapMap).1 hrepresentation)

end

end CellularAutomata.BlockPartitionRuleClass
