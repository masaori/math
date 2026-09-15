/-
正本: content/finite-word-complexity-boundary.ts の具体版。

def_finite_two_symbol_word_set
  → TwoSymbol, FiniteTwoSymbolWord, finiteTwoSymbolWordSet
claim_finite_two_symbol_word_set_cardinality
  → finiteTwoSymbolWordSet_card
def_forbidden_one_run_word_family
  → avoidsForbiddenOneRun, forbiddenOneRunWordFamily
claim_forbidden_one_run_words_full_below_cutoff
  → forbiddenOneRunWordFamily_eq_full_below_cutoff,
    forbiddenOneRunWordFamily_card_below_cutoff
claim_finite_word_counts_do_not_determine_next_length
  → avoidsForbiddenOneRun_nextLength_iff,
    forbiddenOneRunWordFamily_nextLength_eq_erase,
    forbiddenOneRunWordFamily_card_nextLength,
    finiteWordCounts_agree_below_and_diverge_next

有限二元語、連続した一の禁制、有限語個数表の一致と
次の長さでの分岐に固定し、本文と同じ順序で示す。無限舞台の
全配位、実対数、極限、位相的エントロピー、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement
import Mathlib

namespace CellularAutomata.FiniteWordComplexityBoundary

open CellularAutomata.CyclicStageLocalAgreement
attribute [local instance] Fintype.decidableForallFintype

/-! ## 有限二元語 -/

/-- 演算を載せない二元集合。 -/
inductive TwoSymbol
  | zero
  | one
  deriving DecidableEq, Fintype

/-- 長さ `n` の有限二元語。 -/
abbrev FiniteTwoSymbolWord (n : PositiveStage) := Fin n.val → TwoSymbol

/-- 長さ `n` の有限二元語の全体。 -/
def finiteTwoSymbolWordSet (n : PositiveStage) : Finset (FiniteTwoSymbolWord n) :=
  Finset.univ

/-- 有限二元語の個数は `2 ^ n` である。 -/
theorem finiteTwoSymbolWordSet_card (n : PositiveStage) :
    (finiteTwoSymbolWordSet n).card = 2 ^ n.val := by
  rw [finiteTwoSymbolWordSet, Finset.card_univ, Fintype.card_fun,
    Fintype.card_fin]
  rfl

/-! ## 指定長の連続した一を禁じる有限語族 -/

/-- 始点 `i` から禁制長内のオフセット `j` へ進んだ語の位置。 -/
def windowIndex {K n : PositiveStage}
    (i : Fin n.val) (j : Fin (K.val + 1)) (h : i.val + K.val < n.val) : Fin n.val :=
  ⟨i.val + j.val, by omega⟩

/-- 語が長さ `K + 1` の連続した一を含まないこと。 -/
def AvoidsForbiddenOneRun (K n : PositiveStage) (w : FiniteTwoSymbolWord n) : Prop :=
  ∀ i : Fin n.val,
    if h : i.val + K.val < n.val then
      ∃ j : Fin (K.val + 1), w (windowIndex i j h) = TwoSymbol.zero
    else True

/-- 長さ `K + 1` の連続した一を禁じる、長さ `n` の有限語族。 -/
noncomputable def forbiddenOneRunWordFamily
    (K n : PositiveStage) : Finset (FiniteTwoSymbolWord n) :=
  by
    classical
    exact (finiteTwoSymbolWordSet n).filter (AvoidsForbiddenOneRun K n)

/-- `n ≤ K` では禁制条件の始点が存在せず、全ての語が条件を満たす。 -/
theorem avoidsForbiddenOneRun_of_le
    (K n : PositiveStage) (h_nK : n.val ≤ K.val) (w : FiniteTwoSymbolWord n) :
    AvoidsForbiddenOneRun K n w := by
  intro i
  have h : ¬ i.val + K.val < n.val := by omega
  simp [h]

/-- `n ≤ K` では禁制語族は全二元語族に等しい。 -/
theorem forbiddenOneRunWordFamily_eq_full_below_cutoff
    (K n : PositiveStage) (h_nK : n.val ≤ K.val) :
    forbiddenOneRunWordFamily K n = finiteTwoSymbolWordSet n := by
  classical
  unfold forbiddenOneRunWordFamily
  apply Finset.filter_eq_self.2
  intro w _
  exact avoidsForbiddenOneRun_of_le K n h_nK w

/-- `n ≤ K` では禁制語族の個数も `2 ^ n` である。 -/
theorem forbiddenOneRunWordFamily_card_below_cutoff
    (K n : PositiveStage) (h_nK : n.val ≤ K.val) :
    (forbiddenOneRunWordFamily K n).card = 2 ^ n.val := by
  rw [forbiddenOneRunWordFamily_eq_full_below_cutoff K n h_nK]
  exact finiteTwoSymbolWordSet_card n

/-! ## 同じ有限語個数表が区別できない二語族 -/

/-- 禁制長の次の長さ。 -/
def nextLength (K : PositiveStage) : PositiveStage := ⟨K.val + 1, by omega⟩

/-- 全ての位置で一を取る有限語。 -/
def allOneWord (n : PositiveStage) : FiniteTwoSymbolWord n := fun _ => TwoSymbol.one

/-- 次の長さで禁制条件を満たすことは、全一語でないことに等しい。 -/
theorem avoidsForbiddenOneRun_nextLength_iff
    (K : PositiveStage) (w : FiniteTwoSymbolWord (nextLength K)) :
    AvoidsForbiddenOneRun K (nextLength K) w ↔ w ≠ allOneWord (nextLength K) := by
  constructor
  · intro hAvoid hAllOne
    have hStart : (0 : ℕ) + K.val < (nextLength K).val := by
      simp [nextLength]
    have hAtZero := hAvoid ⟨0, by simp [nextLength]⟩
    simp only [dif_pos hStart] at hAtZero
    rcases hAtZero with ⟨j, hj⟩
    have hImpossible : TwoSymbol.one = TwoSymbol.zero := by
      simp [hAllOne, allOneWord] at hj
    exact TwoSymbol.noConfusion hImpossible
  · intro hNotAllOne i
    by_cases hStart : i.val + K.val < (nextLength K).val
    · simp only [dif_pos hStart]
      have hIndexZero : i.val = 0 := by
        have h : i.val + K.val < 1 + K.val := by
          simpa [nextLength, Nat.add_comm] using hStart
        omega
      have hZero : ∃ j : Fin (nextLength K).val, w j = TwoSymbol.zero := by
        by_contra hNoZero
        apply hNotAllOne
        funext j
        cases hValue : w j with
        | zero =>
            exact False.elim (hNoZero ⟨j, hValue⟩)
        | one => rfl
      rcases hZero with ⟨j, hj⟩
      refine ⟨⟨j.val, by simpa [nextLength] using j.isLt⟩, ?_⟩
      have hWindow : windowIndex i ⟨j.val, by simpa [nextLength] using j.isLt⟩ hStart = j := by
        apply Fin.ext
        simp [windowIndex, hIndexZero]
      rw [hWindow]
      exact hj
    · simp [hStart]

/-- 次の長さの禁制語族は、全二元語族から全一語だけを除いた集合である。 -/
theorem forbiddenOneRunWordFamily_nextLength_eq_erase (K : PositiveStage) :
    forbiddenOneRunWordFamily K (nextLength K) =
      (finiteTwoSymbolWordSet (nextLength K)).erase (allOneWord (nextLength K)) := by
  classical
  ext w
  simp only [forbiddenOneRunWordFamily, finiteTwoSymbolWordSet, Finset.mem_filter,
    Finset.mem_erase, Finset.mem_univ, true_and, and_true]
  exact avoidsForbiddenOneRun_nextLength_iff K w

/-- 次の長さの禁制語族の個数は `2 ^ (K + 1) - 1` である。 -/
theorem forbiddenOneRunWordFamily_card_nextLength (K : PositiveStage) :
    (forbiddenOneRunWordFamily K (nextLength K)).card = 2 ^ (K.val + 1) - 1 := by
  rw [forbiddenOneRunWordFamily_nextLength_eq_erase]
  rw [Finset.card_erase_of_mem]
  · rw [finiteTwoSymbolWordSet_card]
    rfl
  · simp [finiteTwoSymbolWordSet]

/-- 二語族の個数表は長さ `K` まで一致するが、次の長さで分かれる。 -/
theorem finiteWordCounts_agree_below_and_diverge_next (K : PositiveStage) :
    (∀ n : PositiveStage, n.val ≤ K.val →
      (forbiddenOneRunWordFamily K n).card = (finiteTwoSymbolWordSet n).card) ∧
    (finiteTwoSymbolWordSet (nextLength K)).card = 2 ^ (K.val + 1) ∧
    (forbiddenOneRunWordFamily K (nextLength K)).card = 2 ^ (K.val + 1) - 1 := by
  refine ⟨?_, ?_, ?_⟩
  · intro n hn
    rw [forbiddenOneRunWordFamily_eq_full_below_cutoff K n hn]
  · simpa [nextLength] using finiteTwoSymbolWordSet_card (nextLength K)
  · exact forbiddenOneRunWordFamily_card_nextLength K

end CellularAutomata.FiniteWordComplexityBoundary
