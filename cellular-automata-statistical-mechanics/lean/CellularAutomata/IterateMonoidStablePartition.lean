/-
章「反復モノイドの安定像による配位集合の分割」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-stable-partition.ts。

安定ファイバー、代表元の所属、代表元の存在一意性、異なるファイバーの非交差、
ファイバーの個数分解、有限走査を人手証明と同じ順序で形式化する。
有限集合・自然数・写像の等号だけを使い、R / C は使わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import CellularAutomata.IterateMonoidStableImage

namespace CellularAutomata.IterateMonoidStablePartition

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `B_F(q) := {y ∈ A^V | E_F(y) = q}`。 -/
def stableFiber (q : stableImage N f) : Set (V → State) :=
  {y | cycleIdempotent N f y = q.1}

theorem mem_stableFiber_iff (q : stableImage N f) (y : V → State) :
    y ∈ stableFiber N f q ↔ cycleIdempotent N f y = q.1 := Iff.rfl

/-- 安定像の各元は自身のファイバーに属する。 -/
theorem representative_mem_stableFiber (q : stableImage N f) :
    q.1 ∈ stableFiber N f q := by
  exact cycleIdempotent_retracts_stableImage N f q.2

/-- 配位 `y` の安定ファイバーを添字付ける、安定像の元 `E_F(y)`。 -/
noncomputable def stableRepresentative (y : V → State) : stableImage N f :=
  ⟨cycleIdempotent N f y, ⟨y, rfl⟩⟩

theorem stableRepresentative_val (y : V → State) :
    (stableRepresentative N f y).1 = cycleIdempotent N f y := rfl

/-- 各配位はただ一つの安定ファイバーに属し、その添字は `E_F(y)` である。 -/
theorem existsUnique_stableFiber (y : V → State) :
    ∃! q : stableImage N f, y ∈ stableFiber N f q := by
  refine ⟨stableRepresentative N f y, rfl, ?_⟩
  intro q hq
  apply Subtype.ext
  exact hq.symm

/-- 異なる安定像の元のファイバーは交わらない。 -/
theorem distinct_stableFibers_disjoint
    {q r : stableImage N f} (hqr : q ≠ r) :
    stableFiber N f q ∩ stableFiber N f r = ∅ := by
  ext y
  constructor
  · rintro ⟨hyq, hyr⟩
    exfalso
    apply hqr
    apply Subtype.ext
    exact hyq.symm.trans hyr
  · simp

/-- `B_F(q)` を全配位の有限走査として書いた表。 -/
noncomputable def stableFiberTable (q : stableImage N f) : Finset (V → State) :=
  Finset.univ.filter (fun y => stableRepresentative N f y = q)

/-- 有限走査表は集合としての安定ファイバーに一致する。 -/
theorem mem_stableFiberTable_iff (q : stableImage N f) (y : V → State) :
    y ∈ stableFiberTable N f q ↔ y ∈ stableFiber N f q := by
  simp only [stableFiberTable, Finset.mem_filter, Finset.mem_univ, true_and,
    mem_stableFiber_iff]
  constructor
  · intro h
    exact congrArg Subtype.val h
  · intro h
    apply Subtype.ext
    exact h

/-- 人手証明の指示値 `δ_F(q,y) ∈ {0,1}`。 -/
noncomputable def stableIndicator (q : stableImage N f) (y : V → State) : ℕ :=
  if y ∈ stableFiberTable N f q then 1 else 0

/-- 各ファイバーの個数は、その指示値を全配位について足した値である。 -/
theorem stableFiberTable_card_eq_sum_indicator (q : stableImage N f) :
    (stableFiberTable N f q).card =
      ∑ y : V → State, stableIndicator N f q y := by
  classical
  rw [Finset.card_eq_sum_ite (Finset.subset_univ (stableFiberTable N f q))]
  rfl

/-- 各配位について代表元はただ一つなので、代表元方向の指示値の和は `1` である。 -/
theorem sum_stableIndicator_eq_one (y : V → State) :
    (∑ q : stableImage N f, stableIndicator N f q y) = 1 := by
  classical
  rw [Fintype.sum_eq_single (stableRepresentative N f y)]
  · simp [stableIndicator, stableFiberTable]
  · intro q hq
    have hne : stableRepresentative N f y ≠ q := Ne.symm hq
    simp [stableIndicator, stableFiberTable, hne]

/-- ファイバーの個数の総和は全配位数に等しい。 -/
theorem sum_card_stableFiberTable_eq_card_config :
    (∑ q : stableImage N f, (stableFiberTable N f q).card) =
      (Finset.univ : Finset (V → State)).card := by
  classical
  calc
    (∑ q : stableImage N f, (stableFiberTable N f q).card) =
        ∑ q : stableImage N f, ∑ y : V → State, stableIndicator N f q y := by
          apply Finset.sum_congr rfl
          intro q _
          exact stableFiberTable_card_eq_sum_indicator N f q
    _ = ∑ y : V → State, ∑ q : stableImage N f, stableIndicator N f q y :=
      Finset.sum_comm
    _ = ∑ _y : V → State, 1 := by
      apply Finset.sum_congr rfl
      intro y _
      exact sum_stableIndicator_eq_one N f y
    _ = (Finset.univ : Finset (V → State)).card := by simp

/-- `Σ_{q∈Q_F}|B_F(q)| = |A^V| = 2^{|V|}`。 -/
theorem stableFiber_cardinality_decomposition :
    (∑ q : stableImage N f, (stableFiberTable N f q).card) =
      2 ^ Fintype.card V := by
  rw [sum_card_stableFiberTable_eq_card_config N f, Finset.card_univ, card_config]

/-- 全ファイバーとその個数を有限集合として列挙する。 -/
noncomputable def stableFibersTable :
    Finset (stableImage N f × Finset (V → State)) :=
  Finset.univ.image (fun q => (q, stableFiberTable N f q))

theorem mem_stableFibersTable_iff
    (q : stableImage N f) (B : Finset (V → State)) :
    (q, B) ∈ stableFibersTable N f ↔ B = stableFiberTable N f q := by
  classical
  simp [stableFibersTable, eq_comm]

/-- 各安定ファイバーの有限走査表は空でないため、その個数は正である。 -/
theorem stableFiberTable_card_pos (q : stableImage N f) :
    0 < (stableFiberTable N f q).card := by
  rw [Finset.card_pos]
  exact ⟨q.1, (mem_stableFiberTable_iff N f q q.1).2
    (representative_mem_stableFiber N f q)⟩

/-- ファイバー所属は有限型上の写像の等号一回として決定可能である。 -/
noncomputable instance (q : stableImage N f) :
    DecidablePred (· ∈ stableFiber N f q) := fun y =>
  inferInstanceAs (Decidable (cycleIdempotent N f y = q.1))

end CellularAutomata.IterateMonoidStablePartition
