/-
正本: content/finite-word-complexity-boundary.ts の必要十分版。

具体版から次の不要な構造を取り除く。

* 有限関数型の個数には、有限な添字型と有限な値型だけを要る。
* 打ち切り以下の一致には、許容述語が全ての元で成り立つことだけを要る。
* 次段階の分岐には、許容述語が一つの指定元との不一致に等しいことだけを要る。

自然数区間、二元状態、連続位置、対数、極限、位相的エントロピー、
実数体、複素数体は一般定理では使わない。
-/
import CellularAutomata.FiniteWordComplexityBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteWordComplexityBoundary

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.FiniteWordComplexityBoundary
attribute [local instance] Fintype.decidableForallFintype

/-! ## 有限関数型の個数に必要な構造 -/

/-- 有限な添字型から有限な値型への全関数の集合。 -/
noncomputable def fullFunctionFamily
    (Index Symbol : Type) [Fintype Index] [Fintype Symbol] :
    Finset (Index → Symbol) := by
  classical
  exact Finset.univ

/-- 有限関数型の個数は、値型の元数の添字型の元数乗である。 -/
theorem fullFunctionFamily_card
    (Index Symbol : Type) [Fintype Index] [Fintype Symbol] :
    (fullFunctionFamily Index Symbol).card =
      Fintype.card Symbol ^ Fintype.card Index := by
  classical
  rw [fullFunctionFamily, Finset.card_univ, Fintype.card_fun]

/-! ## 有限述語による全体集合と一元除外 -/

/-- 有限型のうち、指定した述語を満たす元の集合。 -/
noncomputable def filteredFiniteFamily
    {Element : Type} [Fintype Element]
    (allowed : Element → Prop) : Finset Element := by
  classical
  exact Finset.univ.filter allowed

/-- 許容述語が全ての元で成り立つなら、絞り込み後も全体集合である。 -/
theorem filteredFiniteFamily_eq_full_of_all
    {Element : Type} [Fintype Element]
    (allowed : Element → Prop) (hall : ∀ element, allowed element) :
    filteredFiniteFamily allowed = Finset.univ := by
  classical
  apply Finset.filter_eq_self.2
  intro element _
  exact hall element

/-- 許容述語が指定元との不一致に等しければ、その指定元だけが除かれる。 -/
theorem filteredFiniteFamily_eq_erase_of_iff_ne
    {Element : Type} [Fintype Element] [DecidableEq Element]
    (allowed : Element → Prop) (excluded : Element)
    (hallowed : ∀ element, allowed element ↔ element ≠ excluded) :
    filteredFiniteFamily allowed = (Finset.univ : Finset Element).erase excluded := by
  classical
  ext element
  simp [filteredFiniteFamily, hallowed element]

/-- 一元だけを除く有限族の個数は、全体の元数から一を引いた値である。 -/
theorem filteredFiniteFamily_card_of_iff_ne
    {Element : Type} [Fintype Element] [DecidableEq Element]
    (allowed : Element → Prop) (excluded : Element)
    (hallowed : ∀ element, allowed element ↔ element ≠ excluded) :
    (filteredFiniteFamily allowed).card = Fintype.card Element - 1 := by
  calc
    (filteredFiniteFamily allowed).card =
        ((Finset.univ : Finset Element).erase excluded).card := by
          rw [filteredFiniteFamily_eq_erase_of_iff_ne allowed excluded hallowed]
    _ = (Finset.univ : Finset Element).card - 1 :=
      Finset.card_erase_of_mem (Finset.mem_univ excluded)
    _ = Fintype.card Element - 1 := by rw [Finset.card_univ]

/-! ## 具体版の導出 -/

/-- 具体版の有限二元語の個数は、有限関数型の一般公式から得られる。 -/
theorem finiteTwoSymbolWordSet_card_of_necSuf (n : PositiveStage) :
    (finiteTwoSymbolWordSet n).card = 2 ^ n.val := by
  rw [finiteTwoSymbolWordSet, Finset.card_univ, Fintype.card_fun,
    Fintype.card_fin]
  rfl

/-- 具体版の打ち切り以下の集合一致は、全てを許す述語の一般定理から得られる。 -/
theorem forbiddenOneRunWordFamily_eq_full_below_cutoff_of_necSuf
    (K n : PositiveStage) (h_nK : n.val ≤ K.val) :
    forbiddenOneRunWordFamily K n = finiteTwoSymbolWordSet n := by
  change filteredFiniteFamily (AvoidsForbiddenOneRun K n) = Finset.univ
  exact filteredFiniteFamily_eq_full_of_all _
    (avoidsForbiddenOneRun_of_le K n h_nK)

/-- 具体版の打ち切り以下の個数一致は、一般の集合一致と関数型の個数公式から得られる。 -/
theorem forbiddenOneRunWordFamily_card_below_cutoff_of_necSuf
    (K n : PositiveStage) (h_nK : n.val ≤ K.val) :
    (forbiddenOneRunWordFamily K n).card = 2 ^ n.val := by
  rw [forbiddenOneRunWordFamily_eq_full_below_cutoff_of_necSuf K n h_nK]
  exact finiteTwoSymbolWordSet_card_of_necSuf n

/-- 具体版の次段階の集合等式は、一元除外の一般定理から得られる。 -/
theorem forbiddenOneRunWordFamily_nextLength_eq_erase_of_necSuf
    (K : PositiveStage) :
    forbiddenOneRunWordFamily K (nextLength K) =
      (finiteTwoSymbolWordSet (nextLength K)).erase
        (allOneWord (nextLength K)) := by
  change filteredFiniteFamily (AvoidsForbiddenOneRun K (nextLength K)) =
    (Finset.univ : Finset (FiniteTwoSymbolWord (nextLength K))).erase
      (allOneWord (nextLength K))
  exact filteredFiniteFamily_eq_erase_of_iff_ne _ _
    (avoidsForbiddenOneRun_nextLength_iff K)

/-- 具体版の次段階の個数は、一元除外と関数型の個数公式から得られる。 -/
theorem forbiddenOneRunWordFamily_card_nextLength_of_necSuf
    (K : PositiveStage) :
    (forbiddenOneRunWordFamily K (nextLength K)).card =
      2 ^ (K.val + 1) - 1 := by
  rw [forbiddenOneRunWordFamily_nextLength_eq_erase_of_necSuf]
  rw [Finset.card_erase_of_mem]
  · rw [finiteTwoSymbolWordSet_card_of_necSuf]
    rfl
  · simp [finiteTwoSymbolWordSet]

/-- 具体版の有限表一致と次段階の分岐は、一般定理の特殊化である。 -/
theorem finiteWordCounts_agree_below_and_diverge_next_of_necSuf
    (K : PositiveStage) :
    (∀ n : PositiveStage, n.val ≤ K.val →
      (forbiddenOneRunWordFamily K n).card = (finiteTwoSymbolWordSet n).card) ∧
    (finiteTwoSymbolWordSet (nextLength K)).card = 2 ^ (K.val + 1) ∧
    (forbiddenOneRunWordFamily K (nextLength K)).card =
      2 ^ (K.val + 1) - 1 := by
  refine ⟨?_, ?_, ?_⟩
  · intro n hn
    rw [forbiddenOneRunWordFamily_eq_full_below_cutoff_of_necSuf K n hn]
  · simpa [nextLength] using finiteTwoSymbolWordSet_card_of_necSuf (nextLength K)
  · exact forbiddenOneRunWordFamily_card_nextLength_of_necSuf K

end CellularAutomata.NecSuf.FiniteWordComplexityBoundary
