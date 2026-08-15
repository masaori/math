/-
章「因果集合の一次文献との照合」の必要十分版。

具体版と同じ定義と証明順序を保ち、実際に使う構造だけを残す。

* 一次文献の区間には集合 X と関係 R だけを使う。
* 局所有限な部分順序は、X 上の部分順序性と全区間の有限性の連言である。
* 区間の有限性には X の有限性だけが要る。部分順序性は使わない。
* したがって、有限集合 X 上の任意の部分順序は局所有限である。

セル、状態、近傍、局所規則、自然数時刻、因果集合という物理的名称、
多様体、R / C は使わない。
-/
import CellularAutomata.NecSuf.CausalStructureComparison

namespace CellularAutomata.NecSuf.CausalSetPrimaryLiterature

open CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

variable {Event : Type}

/-- 一次文献の区間 A_R(x,y)。X と関係 R だけで定義する。 -/
def literatureInterval (X : Set Event) (R : Set (Event × Event))
    (x y : Event) : Set Event :=
  {z | z ∈ X ∧ (x, z) ∈ R ∧ (z, y) ∈ R}

/-- 局所有限な部分順序集合。集合と関係だけで定義する。 -/
def IsLocallyFinitePartialOrderOn (X : Set Event) (R : Set (Event × Event)) : Prop :=
  IsPartialOrderOn X R ∧ ∀ x y : Event, (literatureInterval X R x y).Finite

/-- 一次文献の区間は常に台集合 X の部分集合である。 -/
theorem literatureInterval_subset (X : Set Event) (R : Set (Event × Event))
    (x y : Event) : literatureInterval X R x y ⊆ X :=
  fun _ h => h.1

/-- 区間の有限性には台集合 X の有限性だけが要る。 -/
theorem literatureInterval_finite (X : Set Event) (R : Set (Event × Event))
    (hX : X.Finite) (x y : Event) : (literatureInterval X R x y).Finite :=
  hX.subset (literatureInterval_subset X R x y)

/-- 一次文献の区間と前章の順序区間は、同じ集合・関係へ
    特殊化すると同一の所属条件を持つ。 -/
theorem literatureInterval_eq_orderInterval (X : Set Event) (R : Set (Event × Event))
    (x y : Event) :
    literatureInterval X R x y =
      CellularAutomata.NecSuf.CausalStructureComparison.orderInterval X R x y := rfl

/-- 有限集合上の任意の部分順序は局所有限である。
    人手証明と同じく、部分順序性を保持し、各区間の有限性を X の有限性から得る。 -/
theorem locallyFinitePartialOrder_of_finite (X : Set Event) (R : Set (Event × Event))
    (hX : X.Finite) (hPartialOrder : IsPartialOrderOn X R) :
    IsLocallyFinitePartialOrderOn X R := by
  refine ⟨hPartialOrder, ?_⟩
  intro x y
  exact literatureInterval_finite X R hX x y

end CellularAutomata.NecSuf.CausalSetPrimaryLiterature
