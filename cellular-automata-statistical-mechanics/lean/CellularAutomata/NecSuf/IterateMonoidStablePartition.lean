/-
章「反復モノイドの安定像による配位集合の分割」の必要十分版。

具体版と同じ手順（安定ファイバー B(q) = {y | E y = q}、安定像の各元が自身のファイバーに属すること、
各元がただ一つのファイバーに属しその添字が E y であること、異なるファイバーの非交差、
指示値による個数分解、有限走査表、各ファイバーの個数が正であること）を保ち、
実際に使う構造だけを残す。

* ファイバーの定義、代表元 E y の存在と一意性、異なるファイバーの非交差には、
  型 X と自己写像 E : X → X だけが要る。E が冪等であること、E が反復写像であること、
  衝突開始位置・周期の存在は使わない。
* 安定像の各元が自身のファイバーに属すること（したがって各ファイバーの個数が正であること）にだけ
  E の冪等性 `E (E y) = E y` が要る。前章の E_F については前章の恒等性がこれを与える。
* X の有限性と X の等号判定は、全元を代表元ごとに filter する有限走査表と個数分解にだけ要る。
  総和は Fintype.card X で止める。|A|^{|V|} = 2^{|V|} へ進める段は、X が V から 2 値状態集合への
  写像全体であることにだけ依存し、具体版の導出で `card_config` により与える。
* 二値状態、セル、近傍、局所規則、大域写像の反復は現れない。

R / C は使わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.BigOperators

namespace CellularAutomata.NecSuf.IterateMonoidStablePartition

variable {X : Type} (E : X → X)

/-- `Q := E(X)`。冪等性を仮定せず、像そのものだけを置く。 -/
def stableImage : Set X :=
  Set.range E

/-- `B(q) := {y ∈ X | E y = q}`。 -/
def stableFiber (q : stableImage E) : Set X :=
  {y | E y = q.1}

theorem mem_stableFiber_iff (q : stableImage E) (y : X) :
    y ∈ stableFiber E q ↔ E y = q.1 := Iff.rfl

/-- 安定像の各元は自身のファイバーに属する。ここだけ E の冪等性を使う。 -/
theorem representative_mem_stableFiber (hE : ∀ y, E (E y) = E y) (q : stableImage E) :
    q.1 ∈ stableFiber E q := by
  rcases q with ⟨_, y, rfl⟩
  exact hE y

/-- 元 `y` のファイバーを添字付ける、安定像の元 `E y`。 -/
def stableRepresentative (y : X) : stableImage E :=
  ⟨E y, ⟨y, rfl⟩⟩

theorem stableRepresentative_val (y : X) :
    (stableRepresentative E y).1 = E y := rfl

/-- 各元はただ一つのファイバーに属し、その添字は `E y` である。冪等性は不要。 -/
theorem existsUnique_stableFiber (y : X) :
    ∃! q : stableImage E, y ∈ stableFiber E q := by
  refine ⟨stableRepresentative E y, rfl, ?_⟩
  intro q hq
  apply Subtype.ext
  exact hq.symm

/-- 異なる安定像の元のファイバーは交わらない。冪等性は不要。 -/
theorem distinct_stableFibers_disjoint
    {q r : stableImage E} (hqr : q ≠ r) :
    stableFiber E q ∩ stableFiber E r = ∅ := by
  ext y
  constructor
  · rintro ⟨hyq, hyr⟩
    exfalso
    apply hqr
    apply Subtype.ext
    exact hyq.symm.trans hyr
  · simp

section FiniteScan

variable [Fintype X] [DecidableEq X]

/-- 安定像は有限型の部分集合として有限である。 -/
noncomputable instance : Fintype (stableImage E) := Fintype.ofFinite _

/-- `B(q)` を全元の有限走査として書いた表。X の有限性と等号判定を要する。 -/
noncomputable def stableFiberTable (q : stableImage E) : Finset X :=
  Finset.univ.filter (fun y => stableRepresentative E y = q)

/-- 有限走査表は集合としてのファイバーに一致する。 -/
theorem mem_stableFiberTable_iff (q : stableImage E) (y : X) :
    y ∈ stableFiberTable E q ↔ y ∈ stableFiber E q := by
  simp only [stableFiberTable, Finset.mem_filter, Finset.mem_univ, true_and,
    mem_stableFiber_iff]
  constructor
  · intro h
    exact congrArg Subtype.val h
  · intro h
    apply Subtype.ext
    exact h

/-- 人手証明の指示値 `δ(q,y) ∈ {0,1}`。 -/
noncomputable def stableIndicator (q : stableImage E) (y : X) : ℕ :=
  if y ∈ stableFiberTable E q then 1 else 0

/-- 各ファイバーの個数は、その指示値を全元について足した値である。 -/
theorem stableFiberTable_card_eq_sum_indicator (q : stableImage E) :
    (stableFiberTable E q).card =
      ∑ y : X, stableIndicator E q y := by
  classical
  rw [Finset.card_eq_sum_ite (Finset.subset_univ (stableFiberTable E q))]
  rfl

/-- 各元について代表元はただ一つなので、代表元方向の指示値の和は `1` である。 -/
theorem sum_stableIndicator_eq_one (y : X) :
    (∑ q : stableImage E, stableIndicator E q y) = 1 := by
  classical
  rw [Fintype.sum_eq_single (stableRepresentative E y)]
  · simp [stableIndicator, stableFiberTable]
  · intro q hq
    have hne : stableRepresentative E y ≠ q := Ne.symm hq
    simp [stableIndicator, stableFiberTable, hne]

/-- ファイバーの個数の総和は X の元数に等しい。 -/
theorem sum_card_stableFiberTable_eq_card :
    (∑ q : stableImage E, (stableFiberTable E q).card) = Fintype.card X := by
  classical
  calc
    (∑ q : stableImage E, (stableFiberTable E q).card) =
        ∑ q : stableImage E, ∑ y : X, stableIndicator E q y := by
          apply Finset.sum_congr rfl
          intro q _
          exact stableFiberTable_card_eq_sum_indicator E q
    _ = ∑ y : X, ∑ q : stableImage E, stableIndicator E q y :=
      Finset.sum_comm
    _ = ∑ _y : X, 1 := by
      apply Finset.sum_congr rfl
      intro y _
      exact sum_stableIndicator_eq_one E y
    _ = Fintype.card X := by simp

/-- 全ファイバーとその個数を有限集合として列挙する。 -/
noncomputable def stableFibersTable : Finset (stableImage E × Finset X) :=
  Finset.univ.image (fun q => (q, stableFiberTable E q))

theorem mem_stableFibersTable_iff (q : stableImage E) (B : Finset X) :
    (q, B) ∈ stableFibersTable E ↔ B = stableFiberTable E q := by
  classical
  simp [stableFibersTable, eq_comm]

/-- 各ファイバーの有限走査表は空でないため、その個数は正である。冪等性を経由する。 -/
theorem stableFiberTable_card_pos (hE : ∀ y, E (E y) = E y) (q : stableImage E) :
    0 < (stableFiberTable E q).card := by
  rw [Finset.card_pos]
  exact ⟨q.1, (mem_stableFiberTable_iff E q q.1).2
    (representative_mem_stableFiber E hE q)⟩

/-- ファイバー所属は X の等号一回として決定可能である。 -/
noncomputable instance (q : stableImage E) :
    DecidablePred (· ∈ stableFiber E q) := fun y =>
  inferInstanceAs (Decidable (E y = q.1))

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStablePartition
