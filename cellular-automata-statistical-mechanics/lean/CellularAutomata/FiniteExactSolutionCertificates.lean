/-
正本: structured-latex/content/finite-exact-solution-certificates.ts の Lean 具体版。

有限二体写像の古典的非退化性、有限決定可能性、二元集合上で古典的に
非退化だが braid 条件を満たさない明示反例を、人手証明と同じ順序で示す。
有限集合と有限写像だけを使い、ℝ / ℂ、対数、除算、極限は使わない。
-/
import CellularAutomata.FiniteYangBaxterBoundary

namespace CellularAutomata.FiniteExactSolutionCertificates

open CellularAutomata.FiniteYangBaxterBoundary

variable {X : Type*}

/-- `def_finite_pair_map_classical_nondegeneracy` の左片側写像。 -/
def leftSlice (R : PairMap X) (x : X) : X → X :=
  fun y => (R (x, y)).1

/-- `def_finite_pair_map_classical_nondegeneracy` の右片側写像。 -/
def rightSlice (R : PairMap X) (y : X) : X → X :=
  fun x => (R (x, y)).2

/-- `def_finite_pair_map_classical_nondegeneracy`。 -/
def ClassicallyNondegenerate (R : PairMap X) : Prop :=
  (∀ x, Function.Bijective (leftSlice R x)) ∧
    ∀ y, Function.Bijective (rightSlice R y)

/-- `claim_finite_pair_map_classical_nondegeneracy_decidable`。
    有限表の全ての入力と出力について等号を判定すればよい。 -/
instance classicallyNondegenerate_decidable [Fintype X] [DecidableEq X]
    (R : PairMap X) : Decidable (ClassicallyNondegenerate R) := by
  unfold ClassicallyNondegenerate Function.Bijective Function.Injective Function.Surjective
  infer_instance

/-- `claim_classical_nondegeneracy_does_not_imply_yang_baxter` の明示写像。 -/
def binaryNondegenerateCounterexample : PairMap Bool
  | (false, false) => (false, false)
  | (false, true) => (true, false)
  | (true, false) => (true, true)
  | (true, true) => (false, true)

/-- 明示写像の左片側値表は、第一入力が偽なら恒等写像である。 -/
theorem binary_leftSlice_false :
    leftSlice binaryNondegenerateCounterexample false = id := by
  funext y
  cases y <;> rfl

/-- 明示写像の左片側値表は、第一入力が真なら真偽反転である。 -/
theorem binary_leftSlice_true :
    leftSlice binaryNondegenerateCounterexample true = Bool.not := by
  funext y
  cases y <;> rfl

/-- 明示写像の右片側値表は、第二入力が偽なら恒等写像である。 -/
theorem binary_rightSlice_false :
    rightSlice binaryNondegenerateCounterexample false = id := by
  funext x
  cases x <;> rfl

/-- 明示写像の右片側値表は、第二入力が真でも恒等写像である。 -/
theorem binary_rightSlice_true :
    rightSlice binaryNondegenerateCounterexample true = id := by
  funext x
  cases x <;> rfl

/-- 明示写像の四つの片側写像は全単射である。 -/
theorem binaryCounterexample_classicallyNondegenerate :
    ClassicallyNondegenerate binaryNondegenerateCounterexample := by
  constructor
  · intro x
    cases x
    · rw [binary_leftSlice_false]
      exact Function.bijective_id
    · rw [binary_leftSlice_true]
      constructor
      · intro a b hab
        cases a <;> cases b <;> simp_all
      · intro b
        cases b
        · exact ⟨true, rfl⟩
        · exact ⟨false, rfl⟩
  · intro y
    cases y
    · rw [binary_rightSlice_false]
      exact Function.bijective_id
    · rw [binary_rightSlice_true]
      exact Function.bijective_id

/-- 左側 braid 合成の反例入力における各中間値。 -/
theorem binaryCounterexample_left_steps :
    adjacent12 binaryNondegenerateCounterexample (true, false, false) = (true, true, false) ∧
      adjacent23 binaryNondegenerateCounterexample (true, true, false) = (true, true, true) ∧
      adjacent12 binaryNondegenerateCounterexample (true, true, true) = (false, true, true) := by
  decide

/-- 右側 braid 合成の反例入力における各中間値。 -/
theorem binaryCounterexample_right_steps :
    adjacent23 binaryNondegenerateCounterexample (true, false, false) = (true, false, false) ∧
      adjacent12 binaryNondegenerateCounterexample (true, false, false) = (true, true, false) ∧
      adjacent23 binaryNondegenerateCounterexample (true, true, false) = (true, true, true) := by
  decide

/-- 明示写像は有限 braid 条件を満たさない。 -/
theorem binaryCounterexample_not_braid :
    ¬ SatisfiesBraid binaryNondegenerateCounterexample := by
  intro h
  have hw := congrFun h (true, false, false)
  norm_num [SatisfiesBraid, adjacent12, adjacent23, binaryNondegenerateCounterexample,
    Function.comp_def] at hw

/-- 古典的非退化性だけでは有限 Yang--Baxter 条件は従わない。 -/
theorem classicalNondegeneracy_does_not_imply_braid :
    ∃ R : PairMap Bool, ClassicallyNondegenerate R ∧ ¬ SatisfiesBraid R := by
  exact ⟨binaryNondegenerateCounterexample,
    binaryCounterexample_classicallyNondegenerate, binaryCounterexample_not_braid⟩

end CellularAutomata.FiniteExactSolutionCertificates
