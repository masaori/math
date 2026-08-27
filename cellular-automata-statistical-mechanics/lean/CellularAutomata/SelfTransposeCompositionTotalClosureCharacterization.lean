/-
章「自己転置な近傍割り当て全体の合成閉性の特徴づけ」の Lean 具体版。
人手証明の正本は
structured-latex/content/self-transpose-composition-total-closure-characterization.ts。

有限舞台上で、全ての自己転置な近傍割り当てが合成で閉じることと、
舞台の元数が一以下であることの同値を、人手証明と同じ二方向で示す。
有限集合・有限部分集合・自然数だけを使い、ℝ / ℂ は現れない。
-/
import CellularAutomata.SelfTransposeCompositionClosure

namespace CellularAutomata.SelfTransposeCompositionTotalClosureCharacterization

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentTransposeInvolution
open CellularAutomata.SelfTransposeCompositionClosure
open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.SelfTransposeCompositionClosure

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_all_self_transpose_assignments_composition_closed`。 -/
def AllSelfTransposeCompositionClosed (V : Type) [Fintype V] [DecidableEq V] : Prop :=
  ∀ N M : NeighborhoodAssignment V,
    transpose N = N → transpose M = M →
      transpose (composedNeighborhood N M) = composedNeighborhood N M

/-- 人手証明で使う自己ループの証人。 -/
def loopWitness (a : V) : NeighborhoodAssignment V :=
  fun v => if v = a then {a} else ∅

/-- 人手証明で使う二点辺の証人。 -/
def edgeWitness (a b : V) : NeighborhoodAssignment V :=
  fun v => if v = a then {b} else if v = b then {a} else ∅

theorem loopWitness_selfTranspose (a : V) :
    transpose (loopWitness a) = loopWitness a := by
  exact hetWitnessLoop_selfTranspose a

theorem edgeWitness_selfTranspose (a b : V) :
    transpose (edgeWitness a b) = edgeWitness a b := by
  exact hetWitnessEdge_selfTranspose a b

/-- 相異なる二元から作った二つの証人は可換でない。 -/
theorem witnesses_noncommute {a b : V} (hab : a ≠ b) :
    composedNeighborhood (loopWitness a) (edgeWitness a b) ≠
      composedNeighborhood (edgeWitness a b) (loopWitness a) := by
  intro h
  have hAtA := congrFun h a
  have hMem := congrArg (fun S : Finset V => b ∈ S) hAtA
  have hba : b ≠ a := Ne.symm hab
  simp [composedNeighborhood, loopWitness, edgeWitness, hba] at hMem

/-- `claim_all_self_transpose_assignments_composition_closed_iff_subsingleton`。
    順方向は相異なる二元から明示反例を作り、逆方向は全ての元が等しいことから
    二つの合成の所属条件を交換する。 -/
theorem allSelfTransposeCompositionClosed_iff_card_le_one :
    AllSelfTransposeCompositionClosed V ↔ Fintype.card V ≤ 1 := by
  constructor
  · intro hClosed
    by_contra hCard
    have hNotSubsingleton : ¬ Subsingleton V := by
      intro hSubsingleton
      exact hCard (Fintype.card_le_one_iff_subsingleton.mpr hSubsingleton)
    letI : Nontrivial V := not_subsingleton_iff_nontrivial.mp hNotSubsingleton
    obtain ⟨a, b, hab⟩ := exists_pair_ne V
    have hCompositionSelfTranspose := hClosed (loopWitness a) (edgeWitness a b)
      (loopWitness_selfTranspose a) (edgeWitness_selfTranspose a b)
    exact witnesses_noncommute hab
      ((composition_selfTranspose_iff_commute (loopWitness a) (edgeWitness a b)
        (loopWitness_selfTranspose a) (edgeWitness_selfTranspose a b)).1
        hCompositionSelfTranspose)
  · intro hCard N M hN hM
    letI : Subsingleton V := Fintype.card_le_one_iff_subsingleton.mp hCard
    have hCommute : composedNeighborhood N M = composedNeighborhood M N := by
      funext v
      ext w
      simp only [composedNeighborhood, Finset.mem_biUnion]
      constructor
      · rintro ⟨u, huN, hwM⟩
        have huv : u = v := Subsingleton.elim u v
        have hwv : w = v := Subsingleton.elim w v
        subst u
        subst w
        exact ⟨v, hwM, huN⟩
      · rintro ⟨u, huM, hwN⟩
        have huv : u = v := Subsingleton.elim u v
        have hwv : w = v := Subsingleton.elim w v
        subst u
        subst w
        exact ⟨v, hwN, huM⟩
    exact (composition_selfTranspose_iff_commute N M hN hM).2 hCommute

end CellularAutomata.SelfTransposeCompositionTotalClosureCharacterization
