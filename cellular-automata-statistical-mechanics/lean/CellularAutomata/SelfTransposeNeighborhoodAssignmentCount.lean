/-
章「自己転置な近傍割り当ての個数」の Lean 具体版。
人手証明の正本は
structured-latex/content/self-transpose-neighborhood-assignment-count.ts。

`Sym2 V` の元 `s(v,w)` を本文の有限部分集合 `{v,w}` の符号として使う。
対角元 `s(v,v)` は一元部分集合、非対角元は二元部分集合に対応する。
有限舞台、有限近傍割り当て、自然数だけを使い、ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentTransposeInvolution
import Mathlib.Data.Sym.Card

namespace CellularAutomata.SelfTransposeNeighborhoodAssignmentCount

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentTransposeInvolution

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_self_transpose_neighborhood_assignment`。 -/
def SelfTransposeAssignment (V : Type) [Fintype V] [DecidableEq V] :=
  {N : NeighborhoodAssignment V // transpose N = N}

/-- `claim_self_transpose_iff_symmetric_membership`。
    人手証明と同じく転置の所属同値を各方向に一度ずつ使う。 -/
theorem selfTranspose_iff_symmetricMembership (N : NeighborhoodAssignment V) :
    transpose N = N ↔ ∀ v w : V, (w ∈ N v ↔ v ∈ N w) := by
  constructor
  · intro h v w
    calc
      w ∈ N v ↔ w ∈ transpose N v := by rw [h]
      _ ↔ v ∈ N w := mem_transpose N w v
  · intro h
    funext v
    ext w
    calc
      w ∈ transpose N v ↔ v ∈ N w := mem_transpose N w v
      _ ↔ w ∈ N v := (h v w).symm

/-- `def_unordered_cell_pairs`。`s(v,w)` は本文の `{v,w}` を符号化する。 -/
abbrev UnorderedCellPair (V : Type) := Sym2 V

/-- `def_self_transpose_pair_encoding` の所属述語。
    自己転置性により、`s(v,w)` の表示順序に依存しない。 -/
def pairSelected (N : SelfTransposeAssignment V) : Sym2 V → Prop :=
  Sym2.lift ⟨fun v w => w ∈ N.1 v, fun v w => by
    apply propext
    exact selfTranspose_iff_symmetricMembership N.1 |>.1 N.2 v w⟩

/-- `def_self_transpose_pair_encoding`。 -/
noncomputable def pairEncoding (N : SelfTransposeAssignment V) : Finset (Sym2 V) := by
  classical
  exact Finset.univ.filter (pairSelected N)

@[simp] theorem mk_mem_pairEncoding (N : SelfTransposeAssignment V) (v w : V) :
    s(v, w) ∈ pairEncoding N ↔ w ∈ N.1 v := by
  simp [pairEncoding, pairSelected, Sym2.lift_mk]

/-- `def_pair_set_neighborhood_reconstruction`。 -/
def pairReconstruction (B : Finset (Sym2 V)) : NeighborhoodAssignment V :=
  fun v => Finset.univ.filter fun w => s(v, w) ∈ B

@[simp] theorem mem_pairReconstruction (B : Finset (Sym2 V)) (v w : V) :
    w ∈ pairReconstruction B v ↔ s(v, w) ∈ B := by
  simp [pairReconstruction]

/-- 復元した近傍割り当ての所属は対称である。 -/
theorem pairReconstruction_symmetricMembership (B : Finset (Sym2 V)) (v w : V) :
    w ∈ pairReconstruction B v ↔ v ∈ pairReconstruction B w := by
  rw [mem_pairReconstruction, mem_pairReconstruction]
  rw [Sym2.eq_swap]

/-- 復元した近傍割り当ては自己転置である。 -/
theorem pairReconstruction_selfTranspose (B : Finset (Sym2 V)) :
    transpose (pairReconstruction B) = pairReconstruction B :=
  (selfTranspose_iff_symmetricMembership (pairReconstruction B)).2
    (pairReconstruction_symmetricMembership B)

/-- `claim_self_transpose_pair_encoding_bijection`。
    符号と復元の二つの合成を、本文と同じ所属同値と外延性で恒等写像にする。 -/
noncomputable def pairEncodingEquiv : SelfTransposeAssignment V ≃ Finset (Sym2 V) where
  toFun := pairEncoding
  invFun := fun B => ⟨pairReconstruction B, pairReconstruction_selfTranspose B⟩
  left_inv := by
    intro N
    apply Subtype.ext
    funext v
    ext w
    simp
  right_inv := by
    intro B
    ext z
    induction z using Sym2.inductionOn with
    | _ v w => simp

noncomputable instance : Fintype (SelfTransposeAssignment V) :=
  Fintype.ofEquiv (Finset (Sym2 V)) pairEncodingEquiv.symm

/-- `claim_unordered_cell_pair_count` の第一の等号。
    `Sym2 V` は一元部分集合と二元部分集合の非交和なので `n + choose n 2` 個である。 -/
theorem card_unorderedCellPair_choose :
    Fintype.card (UnorderedCellPair V) =
      Fintype.card V + (Fintype.card V).choose 2 := by
  rw [Sym2.card]
  simp [Nat.choose_succ_succ']

/-- `claim_unordered_cell_pair_count` の最終表示。 -/
theorem card_unorderedCellPair :
    Fintype.card (UnorderedCellPair V) =
      Fintype.card V * (Fintype.card V + 1) / 2 := by
  rw [Sym2.card, Nat.choose_two_right]
  simp only [Nat.add_sub_cancel]
  rw [Nat.mul_comm]

/-- `claim_self_transpose_neighborhood_assignment_count`。
    符号化全単射、有限集合の部分集合数、非順序対の個数を順に使う。 -/
theorem card_selfTransposeAssignment :
    Fintype.card (SelfTransposeAssignment V) =
      2 ^ (Fintype.card V * (Fintype.card V + 1) / 2) := by
  rw [Fintype.card_congr pairEncodingEquiv, Fintype.card_finset, card_unorderedCellPair]

/-- 自己転置な近傍割り当てを全て集める有限表。 -/
def selfTransposeTable : Finset (NeighborhoodAssignment V) :=
  Finset.univ.filter fun N => transpose N = N

@[simp] theorem mem_selfTransposeTable (N : NeighborhoodAssignment V) :
    N ∈ selfTransposeTable ↔ transpose N = N := by
  simp [selfTransposeTable]

/-- `claim_self_transpose_neighborhood_assignments_finitely_decidable`。
    有限表への所属判定が自己転置性の判定と一致する。 -/
theorem selfTranspose_finitelyDecidable (N : NeighborhoodAssignment V) :
    N ∈ selfTransposeTable ↔ transpose N = N :=
  mem_selfTransposeTable N

end CellularAutomata.SelfTransposeNeighborhoodAssignmentCount
