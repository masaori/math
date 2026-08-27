/-
章「自己転置な近傍割り当ての合成閉性」の Lean 具体版。
人手証明の正本は
structured-latex/content/self-transpose-composition-closure.ts。

対応表（人手証明 → この file）
  claim_self_transpose_composition_iff_commute
    `composition_selfTranspose_iff_commute`
  def_self_transpose_composition_nonclosure_witness
    `witnessLoop`, `witnessEdge`
  claim_self_transpose_composition_loop_witness_is_self_transpose
    `witnessLoop_selfTranspose`
  claim_self_transpose_composition_edge_witness_is_self_transpose
    `witnessEdge_selfTranspose`
  claim_self_transpose_neighborhood_assignments_not_composition_closed
    `witness_left_at_a`, `witness_right_at_a`, `witness_noncommute`,
    `witness_composition_not_selfTranspose`
  claim_self_transpose_composition_closure_finitely_decidable
    `compositionClosedPairTable`, `mem_compositionClosedPairTable`

有限舞台、有限近傍割り当て、有限表の等号だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.SelfTransposeNeighborhoodAssignmentCount

namespace CellularAutomata.SelfTransposeCompositionClosure

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentTransposeInvolution
open CellularAutomata.SelfTransposeNeighborhoodAssignmentCount

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `claim_self_transpose_composition_iff_commute`。
    転置が合成順序を反転する等式へ二つの自己転置性を順に代入し、
    最後に等号の対称性を使う。 -/
theorem composition_selfTranspose_iff_commute
    (N M : NeighborhoodAssignment V) (hN : transpose N = N) (hM : transpose M = M) :
    transpose (composedNeighborhood N M) = composedNeighborhood N M ↔
      composedNeighborhood N M = composedNeighborhood M N := by
  rw [transpose_composedNeighborhood, hM, hN]
  exact eq_comm

/-! 人手証明の二元舞台 `V_st = {a,b}` と二つの証人。 -/

abbrev WitnessStage := Fin 2

/-- 自己ループ一つからなる証人 `N(a)={a}`, `N(b)=∅`。 -/
def witnessLoop : NeighborhoodAssignment WitnessStage :=
  fun v => if v = 0 then {0} else ∅

/-- 二点を結ぶ証人 `M(a)={b}`, `M(b)={a}`。 -/
def witnessEdge : NeighborhoodAssignment WitnessStage :=
  fun v => if v = 0 then {1} else {0}

/-- `claim_self_transpose_composition_loop_witness_is_self_transpose`。 -/
theorem witnessLoop_selfTranspose : transpose witnessLoop = witnessLoop := by
  decide

/-- `claim_self_transpose_composition_edge_witness_is_self_transpose`。 -/
theorem witnessEdge_selfTranspose : transpose witnessEdge = witnessEdge := by
  decide

/-- 反例の第一の計算 `(N ⋆ M)(a)={b}`。 -/
theorem witness_left_at_a :
    composedNeighborhood witnessLoop witnessEdge 0 = {1} := by
  decide

/-- 反例の第二の計算 `(M ⋆ N)(a)=∅`。 -/
theorem witness_right_at_a :
    composedNeighborhood witnessEdge witnessLoop 0 = ∅ := by
  decide

/-- 二つの証人は可換でない。 -/
theorem witness_noncommute :
    composedNeighborhood witnessLoop witnessEdge ≠
      composedNeighborhood witnessEdge witnessLoop := by
  intro h
  have hAtA := congrFun h 0
  rw [witness_left_at_a, witness_right_at_a] at hAtA
  exact Finset.singleton_ne_empty 1 hAtA

/-- `claim_self_transpose_neighborhood_assignments_not_composition_closed`。
    自己転置な二つの証人の合成は自己転置でない。 -/
theorem witness_composition_not_selfTranspose :
    transpose (composedNeighborhood witnessLoop witnessEdge) ≠
      composedNeighborhood witnessLoop witnessEdge := by
  intro h
  exact witness_noncommute
    ((composition_selfTranspose_iff_commute witnessLoop witnessEdge
      witnessLoop_selfTranspose witnessEdge_selfTranspose).1 h)

/-- 自己転置な二つの割り当てのうち、合成が自己転置になる順序対の有限表。 -/
def compositionClosedPairTable :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.filter fun p =>
    transpose p.1 = p.1 ∧
    transpose p.2 = p.2 ∧
    composedNeighborhood p.1 p.2 = composedNeighborhood p.2 p.1

/-- `claim_self_transpose_composition_closure_finitely_decidable`。
    人手証明と同じく、自己転置性を有限表で判定し、二つの合成表の等号を判定する。 -/
theorem mem_compositionClosedPairTable (N M : NeighborhoodAssignment V) :
    (N, M) ∈ compositionClosedPairTable ↔
      transpose N = N ∧ transpose M = M ∧
      transpose (composedNeighborhood N M) = composedNeighborhood N M := by
  simp only [compositionClosedPairTable, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · rintro ⟨hN, hM, hCommute⟩
    exact ⟨hN, hM,
      (composition_selfTranspose_iff_commute N M hN hM).2 hCommute⟩
  · rintro ⟨hN, hM, hSelfTranspose⟩
    exact ⟨hN, hM,
      (composition_selfTranspose_iff_commute N M hN hM).1 hSelfTranspose⟩

end CellularAutomata.SelfTransposeCompositionClosure
