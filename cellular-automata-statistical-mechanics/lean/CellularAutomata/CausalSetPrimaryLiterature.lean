/-
章「因果集合の一次文献との照合」の具体版。
人手証明の正本は structured-latex/content/causal-set-primary-literature.ts。

一次文献（Bombelli–Lee–Meyer–Sorkin 1987）の本文で確認した「局所有限な部分順序集合」を
順序の言葉だけで定義し、(E_τ, ⪯_τ) がその定義を満たすこと、およびその区間が前章の
順序区間 I_τ(a,b) と集合として等しいことを、人手証明と同じ有限舞台・自然数時刻について
形式化する。連続時空への近似・物理的因果・時刻写像の復元は主張しない（人手証明の remark と同じ）。
物理的意味、多様体、R / C は使わない。

対応表（人手証明 → この file）
  def_locally_finite_partial_order（区間 A_R(x,y)）   `literatureInterval`
  def_locally_finite_partial_order（局所有限性）      `IsLocallyFinitePartialOrderOn`
  同定義中の注記「有限集合上の部分順序は局所有限」   `literatureInterval_finite_of_finset`
  claim_event_order_locally_finite（区間の一致）      `literatureInterval_eq_orderInterval`
  claim_event_order_locally_finite（局所有限部分順序） `eventOrder_locally_finite`
-/
import CellularAutomata.CausalStructureComparison
import CellularAutomata.NecSuf.CausalSetPrimaryLiterature

namespace CellularAutomata.CausalSetPrimaryLiterature

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.TransitiveClosureAntisymmetry
open CellularAutomata.CausalStructureComparison

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 一次文献の区間 A_R(x,y)（`def_locally_finite_partial_order`）。
    有限集合 X ⊆ ℕ × V と関係 R に対し、x から y への R の間にある X の元全体。 -/
def literatureInterval (X : Finset (ℕ × V)) (R : Set ((ℕ × V) × (ℕ × V)))
    (x y : ℕ × V) : Set (ℕ × V) :=
  {z | z ∈ X ∧ (x, z) ∈ R ∧ (z, y) ∈ R}

/-- 局所有限な部分順序集合（`def_locally_finite_partial_order`）。
    部分順序（`IsPartialOrderOn`、前章の `def_partial_order`）であり、
    すべての区間 A_R(x,y) が有限集合であること。 -/
def IsLocallyFinitePartialOrderOn (X : Finset (ℕ × V))
    (R : Set ((ℕ × V) × (ℕ × V))) : Prop :=
  IsPartialOrderOn X R ∧ ∀ x y : ℕ × V, (literatureInterval X R x y).Finite

omit [Fintype V] [DecidableEq V] in
/-- 定義中の注記: X が有限集合なら A_R(x,y) ⊆ X は常に有限である
    （区間の第一条件 z ∈ X による部分集合性）。セル型の有限性・等号判定は不要
    （必要十分版の最初の検査項目）。 -/
theorem literatureInterval_finite_of_finset (X : Finset (ℕ × V))
    (R : Set ((ℕ × V) × (ℕ × V))) (x y : ℕ × V) :
    (literatureInterval X R x y).Finite := by
  apply (Finset.finite_toSet X).subset
  intro z hz
  exact hz.1

/-- `claim_event_order_locally_finite` の後半: 一次文献の区間 A_{⪯_τ}(a,b) と
    前章の区間 I_τ(a,b)（`orderInterval`）は集合として等しい。
    どちらも「c ∈ E_τ かつ a ⪯_τ c かつ c ⪯_τ b」を満たす c 全体として定義されている。 -/
theorem literatureInterval_eq_orderInterval (τ : ℕ) (a b : ℕ × V) :
    literatureInterval (eventSet (V := V) τ) (ReflReachable N f τ) a b
      = orderInterval N f τ a b := by
  ext c
  exact Iff.rfl

/-- `claim_event_order_locally_finite` の前半: (E_τ, ⪯_τ) は局所有限な部分順序集合である。
    人手証明の順序どおり、部分順序性は `claim_reachability_partial_order`
    （`reflReachable_partial_order`）、区間の有限性は区間の一致
    （`literatureInterval_eq_orderInterval`）と `claim_order_interval_finite`
    （`orderInterval_finite`）から得る。E_τ の有限性は `eventSet` が `Finset` であることが担う。 -/
theorem eventOrder_locally_finite (τ : ℕ) :
    IsLocallyFinitePartialOrderOn (eventSet (V := V) τ) (ReflReachable N f τ) := by
  refine ⟨reflReachable_partial_order N f τ, ?_⟩
  intro a b
  rw [literatureInterval_eq_orderInterval N f τ a b]
  exact orderInterval_finite N f τ a b

/-! ## 必要十分版からの導出

以下は、上の具体版の定義・定理が必要十分版
(`NecSuf.CausalSetPrimaryLiterature`) をイベント集合と反射的到達可能関係へ
特殊化したものであることの導出。 -/

omit [Fintype V] [DecidableEq V] in
/-- 具体版の一次文献の区間は、必要十分版を有限イベント集合へ
    特殊化したものである。 -/
theorem literatureInterval_eq_necessary_sufficient (X : Finset (ℕ × V))
    (R : Set ((ℕ × V) × (ℕ × V))) (x y : ℕ × V) :
    literatureInterval X R x y =
      CellularAutomata.NecSuf.CausalSetPrimaryLiterature.literatureInterval
        (↑X : Set (ℕ × V)) R x y := rfl

omit [Fintype V] [DecidableEq V] in
/-- 有限集合上の区間の有限性が、必要十分版の「台集合の有限性だけ」
    を使う定理から得られること。 -/
theorem literatureInterval_finite_of_finset_from_necessary_sufficient
    (X : Finset (ℕ × V)) (R : Set ((ℕ × V) × (ℕ × V))) (x y : ℕ × V) :
    (literatureInterval X R x y).Finite := by
  rw [literatureInterval_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.CausalSetPrimaryLiterature.literatureInterval_finite
    (↑X : Set (ℕ × V)) R (Finset.finite_toSet X) x y

omit [Fintype V] [DecidableEq V] in
/-- 具体版の局所有限性述語は、必要十分版を有限集合の強制に
    特殊化したものである。 -/
theorem isLocallyFinitePartialOrderOn_iff_necessary_sufficient
    (X : Finset (ℕ × V)) (R : Set ((ℕ × V) × (ℕ × V))) :
    IsLocallyFinitePartialOrderOn X R ↔
      CellularAutomata.NecSuf.CausalSetPrimaryLiterature.IsLocallyFinitePartialOrderOn
        (↑X : Set (ℕ × V)) R := Iff.rfl

/-- `(E_τ, ⪯_τ)` の局所有限部分順序性が、必要十分版へ
    イベント集合の有限性と既証明の部分順序性を渡して得られること。 -/
theorem eventOrder_locally_finite_from_necessary_sufficient (τ : ℕ) :
    IsLocallyFinitePartialOrderOn (eventSet (V := V) τ) (ReflReachable N f τ) := by
  apply (isLocallyFinitePartialOrderOn_iff_necessary_sufficient
    (V := V) (eventSet (V := V) τ) (ReflReachable N f τ)).mpr
  exact CellularAutomata.NecSuf.CausalSetPrimaryLiterature.locallyFinitePartialOrder_of_finite
    (↑(eventSet (V := V) τ) : Set (ℕ × V)) (ReflReachable N f τ)
    (Finset.finite_toSet _) (reflReachable_partial_order_from_necessary_sufficient N f τ)

end CellularAutomata.CausalSetPrimaryLiterature
