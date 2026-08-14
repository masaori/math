/-
章「時間展開上の直接依存」の必要十分版。

具体版と同じ制限写像・冗長拡大・一点反転の順序を保ち、実際に使う構造だけを残す。

* 大域写像と一点反転の特徴づけには、舞台と状態型の有限性は要らない。
  舞台の等号判定と、状態側の「別値の一意性」だけを使う。
* イベント集合の個数には、選んだ有限時間集合と舞台の有限性だけを使う。
* 一段依存での時刻増加には、時間型、次時刻写像 `next`、関係 `lt`、
  `lt s (next s)` だけを使う。自然数のその他の構造は要らない。

グラフ、群、物理的因果、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.RedundantNeighbor

namespace CellularAutomata.NecSuf.TimeExpansionDependency

open CellularAutomata.NecSuf.EssentialDependency
open CellularAutomata.NecSuf.RedundantNeighbor

variable {V A Time : Type}
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → A) → A)

/-- 必要十分版の大域写像。各セルの値は制限写像だけを通して局所規則から得る。 -/
def globalMap (y : V → A) : V → A :=
  fun v => f v (restrict (N v) y)

/-- 大域写像の各値写像は、局所規則の冗長拡大に等しい。 -/
theorem globalMap_eq_extendRule (v : V) (y : V → A) :
    globalMap N f y v = extendRule (N v) (f v) y := rfl

/-- 大域値が一点反転で変わることは、その元が局所規則の本質的依存元であることと同値。
    証明は具体版と同じく、大域値を冗長拡大へ書き換え、一点反転同値、
    制限・延長による依存移送の順に適用する。 -/
theorem globalFlip_iff_essentialDep
    [DecidableEq V]
    (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (base : A)
    (u v : V) :
    (∃ y : V → A,
      globalMap N f y v ≠ globalMap N f (flip nu u y) v) ↔
      ∃ hu : u ∈ N v, EssentialDep (f v) ⟨u, hu⟩ := by
  show (∃ y : V → A,
    extendRule (N v) (f v) y ≠ extendRule (N v) (f v) (flip nu u y)) ↔ _
  rw [← essentialDep_iff_flip nu uniqueAlternative (extendRule (N v) (f v)) u]
  exact essentialDep_extendRule_iff (N v) nu uniqueAlternative base (f v) u

/-- 選んだ有限時間集合と舞台の直積として得るイベント集合。
    直積の構成と個数の積の法則に等号判定は要らないので、
    要るのは選んだ時間集合の有限性（`Finset Time`）と舞台の有限性だけである。 -/
def eventSet [Fintype V] (I : Finset Time) : Finset (Time × V) :=
  I ×ˢ (Finset.univ : Finset V)

/-- イベント集合の個数は、二つの有限集合の個数の積である。 -/
theorem card_eventSet [Fintype V] (I : Finset Time) :
    (eventSet (V := V) I).card = I.card * Fintype.card V := by
  rw [eventSet, Finset.card_product, Finset.card_univ]

/-- 有限集合化の前にある、一段依存の点ごとの条件。 -/
def DirectDep (next : Time → Time) (source target : Time × V) : Prop :=
  target.1 = next source.1 ∧
    ∃ hu : source.2 ∈ N target.2, EssentialDep (f target.2) ⟨source.2, hu⟩

/-- 一段依存のセルは、対象セルの近傍に属する。 -/
theorem directDep_imp_mem_neighborhood (next : Time → Time)
    (source target : Time × V) (h : DirectDep N f next source target) :
    source.2 ∈ N target.2 := by
  exact h.2.choose

/-- 次時刻が常に厳密に後なら、一段依存で時刻は厳密に増える。 -/
theorem time_strictly_increases
    (next : Time → Time) (lt : Time → Time → Prop)
    (lt_next : ∀ s : Time, lt s (next s))
    (source target : Time × V) (h : DirectDep N f next source target) :
    lt source.1 target.1 := by
  exact h.1 ▸ lt_next source.1

end CellularAutomata.NecSuf.TimeExpansionDependency
