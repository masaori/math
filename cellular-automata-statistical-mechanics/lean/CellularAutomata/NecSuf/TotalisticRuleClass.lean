/-
章「有限な閉近傍舞台上の総和型局所規則族」の Lean 必要十分版。

必要な構造の検査結果:
  - ある署名写像を経由することから、同じ署名を持つ入力で出力が一致することを導く段には、
    型のインスタンスを一つも要しない。
  - 逆向きには、実現されない署名を埋める出力を一つ要る。添字、入力、署名、出力の有限性、
    閉近傍の自己包含と対称性、二元状態は要らない。
  - 有限決定にだけ、添字と各入力型の有限性、署名と出力の等号判定を要する。
  - 一状態数の上界には、有限な台とその等号判定だけを要する。
  - 状態同士の加法、対数、除算、全配位、極限、実数体、複素数体は使わない。
-/
import CellularAutomata.TotalisticRuleClass

namespace CellularAutomata.NecSuf.TotalisticRuleClass

universe uI uX uS uA uW

variable {I : Type uI} {X : I → Type uX} {S : Type uS} {A : Type uA}

/-- 入力族上の写像が、一つの署名写像を経由すること。 -/
def FactorsThrough (signature : (i : I) → X i → S) (f : (i : I) → X i → A) : Prop :=
  ∃ phi : S → A, ∀ (i : I) (x : X i), f i x = phi (signature i x)

/-- 同じ署名を持つ入力では出力が一致するという、繊維上の整合条件。 -/
def FiberConsistent (signature : (i : I) → X i → S) (f : (i : I) → X i → A) : Prop :=
  ∀ (i j : I) (x : X i) (y : X j), signature i x = signature j y → f i x = f j y

/-- 署名写像を経由する写像族は、署名の各繊維上で一定である。 -/
theorem factorsThrough_implies_fiberConsistent
    (signature : (i : I) → X i → S) (f : (i : I) → X i → A) :
    FactorsThrough signature f → FiberConsistent signature f := by
  rintro ⟨phi, hphi⟩ i j x y hsignature
  calc
    f i x = phi (signature i x) := hphi i x
    _ = phi (signature j y) := congrArg phi hsignature
    _ = f j y := (hphi j y).symm

/-- 繊維上で整合する写像族は、実現されない署名を一つの出力で埋めれば署名写像を経由する。 -/
theorem fiberConsistent_implies_factorsThrough
    (defaultOutput : A) (signature : (i : I) → X i → S) (f : (i : I) → X i → A) :
    FiberConsistent signature f → FactorsThrough signature f := by
  classical
  intro hfiber
  let Realization := Σ i : I, X i
  let phi : S → A := fun s =>
    if hexists : ∃ z : Realization, signature z.1 z.2 = s then
      f (Classical.choose hexists).1 (Classical.choose hexists).2
    else
      defaultOutput
  refine ⟨phi, ?_⟩
  intro i x
  let z : Realization := ⟨i, x⟩
  have hexists : ∃ z' : Realization, signature z'.1 z'.2 = signature i x := ⟨z, rfl⟩
  have hchosen := Classical.choose_spec hexists
  rw [show phi (signature i x) =
      f (Classical.choose hexists).1 (Classical.choose hexists).2 by
    simp only [phi, dif_pos hexists]]
  exact (hfiber (Classical.choose hexists).1 i (Classical.choose hexists).2 x hchosen).symm

/-- 署名写像を経由することは、署名の各繊維上で一定であることと同値である。 -/
theorem factorsThrough_iff_fiberConsistent
    (defaultOutput : A) (signature : (i : I) → X i → S) (f : (i : I) → X i → A) :
    FactorsThrough signature f ↔ FiberConsistent signature f := by
  constructor
  · exact factorsThrough_implies_fiberConsistent signature f
  · exact fiberConsistent_implies_factorsThrough defaultOutput signature f

/-- 有限な台の付属型を条件で絞った個数は、台を含む型全体の元数以下である。 -/
theorem filteredAttachedCard_le_typeCard
    {W : Type uW} [Fintype W] [DecidableEq W]
    (support : Finset W) (predicate : ↑support → Prop) [DecidablePred predicate] :
    (support.attach.filter predicate).card ≤ Fintype.card W := by
  calc
    (support.attach.filter predicate).card ≤ support.attach.card := Finset.card_filter_le _ _
    _ = support.card := Finset.card_attach
    _ ≤ Fintype.card W := Finset.card_le_univ _

section FiniteDecision

variable [Fintype I] [∀ i : I, Fintype (X i)] [DecidableEq S] [DecidableEq A]

/-- 有限な添字族と有限な入力型では、繊維上の整合条件を有限決定できる。 -/
instance fiberConsistentDecidable
    (signature : (i : I) → X i → S) (f : (i : I) → X i → A) :
    Decidable (FiberConsistent signature f) := by
  unfold FiberConsistent
  infer_instance

/-- 出力を一つ与えれば、署名写像を経由することも繊維条件を通じて有限決定できる。 -/
def factorsThroughDecidable
    (defaultOutput : A) (signature : (i : I) → X i → S) (f : (i : I) → X i → A) :
    Decidable (FactorsThrough signature f) :=
  decidable_of_iff (FiberConsistent signature f)
    (factorsThrough_iff_fiberConsistent defaultOutput signature f).symm

end FiniteDecision

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.TotalisticRuleClass

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の一状態数上界は、有限な台を条件で絞った個数の一般上界の特殊化である。 -/
theorem oneCount_le_stage_card_of_necSuf
    (N : V → Finset V) (v : V) (x : ↑(N v) → State) :
    oneCount N v x ≤ Fintype.card V := by
  exact filteredAttachedCard_le_typeCard (openNeighborhood N v)
    (fun w => x ⟨w.1, Finset.mem_of_mem_erase w.2⟩ = State.one)

/-- 具体版の順方向は、署名写像を経由する任意の写像族に対する一般主張の特殊化である。 -/
theorem totalistic_implies_pairwise_of_necSuf
    (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N) (f : LocalRuleFamily N) :
    IsTotalistic N hstage f → PairwiseConsistent N hstage f := by
  change FactorsThrough (localSignature N hstage.1) f →
    FiberConsistent (localSignature N hstage.1) f
  exact factorsThrough_implies_fiberConsistent (localSignature N hstage.1) f

/-- 具体版の逆方向は、未実現署名を状態零で埋める一般構成の特殊化である。 -/
theorem pairwise_implies_totalistic_of_necSuf
    (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N) (f : LocalRuleFamily N) :
    PairwiseConsistent N hstage f → IsTotalistic N hstage f := by
  change FiberConsistent (localSignature N hstage.1) f →
    FactorsThrough (localSignature N hstage.1) f
  exact fiberConsistent_implies_factorsThrough State.zero (localSignature N hstage.1) f

/-- 具体版の特徴づけは、任意の署名写像に対する繊維特徴づけの特殊化である。 -/
theorem totalistic_iff_pairwise_of_necSuf
    (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N) (f : LocalRuleFamily N) :
    IsTotalistic N hstage f ↔ PairwiseConsistent N hstage f := by
  change FactorsThrough (localSignature N hstage.1) f ↔
    FiberConsistent (localSignature N hstage.1) f
  exact factorsThrough_iff_fiberConsistent State.zero (localSignature N hstage.1) f

/-- 具体版の対比較条件は、有限な添字族と有限な入力型に対する一般決定の特殊化である。 -/
theorem pairwiseConsistent_finite_decidable_of_necSuf
    (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N) (f : LocalRuleFamily N) :
    PairwiseConsistent N hstage f ∨ ¬ PairwiseConsistent N hstage f := by
  change FiberConsistent (localSignature N hstage.1) f ∨
    ¬ FiberConsistent (localSignature N hstage.1) f
  exact @Decidable.em _ (fiberConsistentDecidable (localSignature N hstage.1) f)

/-- 具体版の総和型所属は、繊維条件を通じた一般決定の特殊化である。 -/
theorem totalistic_finite_decidable_of_necSuf
    (N : V → Finset V) (hstage : IsClosedNeighborhoodStage N) (f : LocalRuleFamily N) :
    IsTotalistic N hstage f ∨ ¬ IsTotalistic N hstage f := by
  change FactorsThrough (localSignature N hstage.1) f ∨
    ¬ FactorsThrough (localSignature N hstage.1) f
  exact @Decidable.em _
    (factorsThroughDecidable State.zero (localSignature N hstage.1) f)

end Derivation

end CellularAutomata.NecSuf.TotalisticRuleClass
