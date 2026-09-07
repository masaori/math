/-
正本: structured-latex/content/totalistic-rule-class.ts の具体版。

有限な閉近傍舞台、演算を持たない二元状態、局所規則族を固定し、
中心値と開近傍で状態 one を取るセルの個数からなる局所署名を定義する。
総和型であることと同じ署名を持つ全局所入力対で出力が一致することの同値、
およびその有限決定可能性を人手証明と同じ順序で示す。

有限型・有限集合・自然数だけを使う。状態同士の加法、対数、除算、
全配位、極限、実数体・複素数体は使わない。
-/
import CellularAutomata.EssentialDependency
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Finset.Card

namespace CellularAutomata.TotalisticRuleClass

open CellularAutomata.EssentialDependency

noncomputable section

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限近傍割り当てが自己包含かつ対称であるという、有限な閉近傍舞台の条件。 -/
def IsClosedNeighborhoodStage (N : V → Finset V) : Prop :=
  (∀ v : V, v ∈ N v) ∧ (∀ u v : V, u ∈ N v ↔ v ∈ N u)

/-- セル `v` の開近傍。 -/
def openNeighborhood (N : V → Finset V) (v : V) : Finset V :=
  (N v).erase v

/-- 局所入力のうち、開近傍で状態 `one` を取るセルの個数。 -/
def oneCount (N : V → Finset V) (v : V) (x : ↑(N v) → State) : ℕ :=
  ((openNeighborhood N v).attach.filter fun w =>
    x ⟨w.1, Finset.mem_of_mem_erase w.2⟩ = State.one).card

/-- 一状態数は舞台全体のセル数以下である。 -/
theorem oneCount_le_stage_card (N : V → Finset V) (v : V) (x : ↑(N v) → State) :
    oneCount N v x ≤ Fintype.card V := by
  calc
    oneCount N v x
        ≤ (openNeighborhood N v).attach.card := Finset.card_filter_le _ _
    _ = (openNeighborhood N v).card := Finset.card_attach
    _ ≤ Fintype.card V := Finset.card_le_univ _

/-- 中心値と一状態数からなる有限な局所署名の集合。 -/
abbrev LocalSignature (V : Type) [Fintype V] := State × Fin (Fintype.card V + 1)

/-- 局所入力を、その中心値と開近傍の一状態数へ送る。 -/
def localSignature (N : V → Finset V) (hself : ∀ v : V, v ∈ N v)
    (v : V) (x : ↑(N v) → State) : LocalSignature V :=
  (x ⟨v, hself v⟩, ⟨oneCount N v x, Nat.lt_succ_of_le (oneCount_le_stage_card N v x)⟩)

/-- 有限な閉近傍舞台上の局所規則族。 -/
abbrev LocalRuleFamily (N : V → Finset V) :=
  (v : V) → (↑(N v) → State) → State

/-- 一つの有限署名表を経由する総和型局所規則族。 -/
def IsTotalistic (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : Prop :=
  ∃ φ : LocalSignature V → State, ∀ (v : V) (x : ↑(N v) → State),
    f v x = φ (localSignature N hstage.1 v x)

/-- 同じ局所署名を持つ全入力対で出力が一致するという有限比較条件。 -/
def PairwiseConsistent (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : Prop :=
  ∀ (u v : V) (x : ↑(N u) → State) (y : ↑(N v) → State),
    localSignature N hstage.1 u x = localSignature N hstage.1 v y → f u x = f v y

/-- 総和型なら、同じ署名を持つ入力対の出力は一致する。 -/
theorem totalistic_implies_pairwise (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : IsTotalistic N hstage f → PairwiseConsistent N hstage f := by
  rintro ⟨φ, hφ⟩ u v x y hsignature
  calc
    f u x = φ (localSignature N hstage.1 u x) := hφ u x
    _ = φ (localSignature N hstage.1 v y) := congrArg φ hsignature
    _ = f v y := (hφ v y).symm

/-- 対比較条件から、実現署名では一つの出力を選び、非実現署名を `zero` で埋めた表を構成できる。 -/
theorem pairwise_implies_totalistic (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : PairwiseConsistent N hstage f → IsTotalistic N hstage f := by
  intro hpair
  let Realization := Σ v : V, ↑(N v) → State
  let φ : LocalSignature V → State := fun signature =>
    if hexists : ∃ z : Realization, localSignature N hstage.1 z.1 z.2 = signature then
      f (Classical.choose hexists).1 (Classical.choose hexists).2
    else
      State.zero
  refine ⟨φ, ?_⟩
  intro v x
  let z : Realization := ⟨v, x⟩
  have hexists : ∃ z' : Realization,
      localSignature N hstage.1 z'.1 z'.2 = localSignature N hstage.1 v x := ⟨z, rfl⟩
  have hchosen := Classical.choose_spec hexists
  rw [show φ (localSignature N hstage.1 v x) =
      f (Classical.choose hexists).1 (Classical.choose hexists).2 by
    simp only [φ, dif_pos hexists]]
  exact (hpair (Classical.choose hexists).1 v (Classical.choose hexists).2 x hchosen).symm

/-- 総和型であることは、同じ署名を持つ全局所入力対の比較条件と同値である。 -/
theorem totalistic_iff_pairwise (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : IsTotalistic N hstage f ↔ PairwiseConsistent N hstage f := by
  constructor
  · exact totalistic_implies_pairwise N hstage f
  · exact pairwise_implies_totalistic N hstage f

/-- 全セルと全局所入力対の有限走査により、対比較条件は決定できる。 -/
instance pairwiseConsistentDecidable (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : Decidable (PairwiseConsistent N hstage f) := by
  unfold PairwiseConsistent
  infer_instance

/-- 必要十分条件を通じて、有限な閉近傍舞台上の総和型所属は有限決定できる。 -/
instance totalisticDecidable (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N)
    (f : LocalRuleFamily N) : Decidable (IsTotalistic N hstage f) :=
  decidable_of_iff (PairwiseConsistent N hstage f) (totalistic_iff_pairwise N hstage f).symm

end

end CellularAutomata.TotalisticRuleClass
