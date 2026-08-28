/-
章「合成冪等な近傍割り当ての特徴づけ」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-composition-idempotents.ts。

合成冪等性と「推移性かつ二段分解可能性」の同値、自己近傍を含む場合、
二条件が互いを含意しない有限反例、有限決定を人手証明と同じ順序で示す。
有限集合・有限部分集合・有限写像だけを使い、ℝ / ℂ は現れない。
-/
import CellularAutomata.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NeighborhoodAssignmentCompositionIdempotents

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_composition_idempotent_neighborhood_assignment`。 -/
def IsCompositionIdempotent (N : NeighborhoodAssignment V) : Prop :=
  composedNeighborhood N N = N

/-- `def_transitive_neighborhood_assignment`。 -/
def IsTransitive (N : NeighborhoodAssignment V) : Prop :=
  ∀ v u w : V, u ∈ N v → w ∈ N u → w ∈ N v

/-- `def_two_step_factorable_neighborhood_assignment`。 -/
def IsTwoStepFactorable (N : NeighborhoodAssignment V) : Prop :=
  ∀ v w : V, w ∈ N v → ∃ u ∈ N v, w ∈ N u

instance instDecidableIsCompositionIdempotent (N : NeighborhoodAssignment V) :
    Decidable (IsCompositionIdempotent N) := by
  unfold IsCompositionIdempotent
  infer_instance

instance instDecidableIsTransitive (N : NeighborhoodAssignment V) :
    Decidable (IsTransitive N) := by
  unfold IsTransitive
  infer_instance

instance instDecidableIsTwoStepFactorable (N : NeighborhoodAssignment V) :
    Decidable (IsTwoStepFactorable N) := by
  unfold IsTwoStepFactorable
  infer_instance

/-- `claim_composition_idempotent_neighborhood_assignment_characterization`。
    順方向は合成近傍の等号から推移性と二段分解可能性を分けて取り出し、
    逆方向は各値の両包含から写像の等号を得る。 -/
theorem compositionIdempotent_iff_transitive_and_twoStepFactorable
    (N : NeighborhoodAssignment V) :
    IsCompositionIdempotent N ↔ IsTransitive N ∧ IsTwoStepFactorable N := by
  constructor
  · intro hIdem
    constructor
    · intro v u w huN hwN
      have hwComp : w ∈ composedNeighborhood N N v :=
        Finset.mem_biUnion.mpr ⟨u, huN, hwN⟩
      rw [hIdem] at hwComp
      exact hwComp
    · intro v w hwN
      have hwComp : w ∈ composedNeighborhood N N v := by
        rw [hIdem]
        exact hwN
      exact Finset.mem_biUnion.mp hwComp
  · rintro ⟨hTransitive, hFactorable⟩
    funext v
    ext w
    constructor
    · intro hwComp
      obtain ⟨u, huN, hwN⟩ := Finset.mem_biUnion.mp hwComp
      exact hTransitive v u w huN hwN
    · intro hwN
      obtain ⟨u, huN, hwNu⟩ := hFactorable v w hwN
      exact Finset.mem_biUnion.mpr ⟨u, huN, hwNu⟩

/-- `claim_reflexive_neighborhood_assignment_idempotent_iff_transitive`。
    自己近傍の包含から、二段分解の証人に `w` 自身を取る。 -/
theorem compositionIdempotent_iff_transitive_of_self_mem
    (N : NeighborhoodAssignment V) (hSelf : ∀ v : V, v ∈ N v) :
    IsCompositionIdempotent N ↔ IsTransitive N := by
  constructor
  · intro hIdem
    exact (compositionIdempotent_iff_transitive_and_twoStepFactorable N).mp hIdem |>.1
  · intro hTransitive
    apply (compositionIdempotent_iff_transitive_and_twoStepFactorable N).mpr
    refine ⟨hTransitive, ?_⟩
    intro v w hwN
    exact ⟨w, hwN, hSelf w⟩

/-! 人手証明の二つの有限反例。 -/

abbrev TransitiveOnlyStage := Fin 2

def transitiveOnlyWitness : NeighborhoodAssignment TransitiveOnlyStage :=
  fun v => if v = 0 then {1} else ∅

theorem transitiveOnlyWitness_isTransitive :
    IsTransitive transitiveOnlyWitness := by
  decide

theorem transitiveOnlyWitness_not_twoStepFactorable :
    ¬ IsTwoStepFactorable transitiveOnlyWitness := by
  decide

abbrev FactorableOnlyStage := Fin 3

def factorableOnlyWitness : NeighborhoodAssignment FactorableOnlyStage :=
  fun v => if v = 0 then {0, 1} else if v = 1 then {1, 2} else {2}

theorem factorableOnlyWitness_isTwoStepFactorable :
    IsTwoStepFactorable factorableOnlyWitness := by
  decide

theorem factorableOnlyWitness_not_transitive :
    ¬ IsTransitive factorableOnlyWitness := by
  decide

/-- `claim_transitive_and_factorable_neighborhood_assignment_independent`。 -/
theorem transitive_and_twoStepFactorable_independent :
    (∃ N : NeighborhoodAssignment TransitiveOnlyStage,
      IsTransitive N ∧ ¬ IsTwoStepFactorable N) ∧
    (∃ N : NeighborhoodAssignment FactorableOnlyStage,
      IsTwoStepFactorable N ∧ ¬ IsTransitive N) := by
  exact ⟨⟨transitiveOnlyWitness, transitiveOnlyWitness_isTransitive,
      transitiveOnlyWitness_not_twoStepFactorable⟩,
    ⟨factorableOnlyWitness, factorableOnlyWitness_isTwoStepFactorable,
      factorableOnlyWitness_not_transitive⟩⟩

/-- `claim_composition_idempotent_neighborhood_assignment_finite_decidable`。
    `Fintype` が三重全称量化と二重全称量化・有限存在量化を有限走査に落とす。 -/
theorem finite_decidable (N : NeighborhoodAssignment V) :
    (IsCompositionIdempotent N ∨ ¬ IsCompositionIdempotent N) ∧
      (IsTransitive N ∨ ¬ IsTransitive N) ∧
      (IsTwoStepFactorable N ∨ ¬ IsTwoStepFactorable N) := by
  exact ⟨Decidable.em _, Decidable.em _, Decidable.em _⟩

end CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
