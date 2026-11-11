import Ising2DLambda.KacWard.BoundaryVertexSidePropagation
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcludedOfWalk
import Ising2DLambda.KacWard.WalkStepInteriorSide
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

set_option maxHeartbeats 2000000

/-- The four directional descriptions of two actual successive grid steps
specialize the four-cell boundary rule at their common vertex. -/
private theorem gridConsecutiveInteriorSides_eq
    (cells : Finset GridCell) (r₀ c₀ r₁ c₁ r₂ c₂ : ℤ)
    (s₀ s₁ : Bool)
    (hfirst :
      (r₁ = r₀ + 1 ∧ c₁ = c₀ ∧
        ((r₀, c₀) ∈ cells ↔ s₀ = true) ∧
        ((r₀, c₀ - 1) ∈ cells ↔ s₀ = false)) ∨
      (r₁ = r₀ - 1 ∧ c₁ = c₀ ∧
        ((r₀ - 1, c₀ - 1) ∈ cells ↔ s₀ = true) ∧
        ((r₀ - 1, c₀) ∈ cells ↔ s₀ = false)) ∨
      (r₁ = r₀ ∧ c₁ = c₀ + 1 ∧
        ((r₀ - 1, c₀) ∈ cells ↔ s₀ = true) ∧
        ((r₀, c₀) ∈ cells ↔ s₀ = false)) ∨
      (r₁ = r₀ ∧ c₁ = c₀ - 1 ∧
        ((r₀, c₀ - 1) ∈ cells ↔ s₀ = true) ∧
        ((r₀ - 1, c₀ - 1) ∈ cells ↔ s₀ = false)))
    (hsecond :
      (r₂ = r₁ + 1 ∧ c₂ = c₁ ∧
        ((r₁, c₁) ∈ cells ↔ s₁ = true) ∧
        ((r₁, c₁ - 1) ∈ cells ↔ s₁ = false)) ∨
      (r₂ = r₁ - 1 ∧ c₂ = c₁ ∧
        ((r₁ - 1, c₁ - 1) ∈ cells ↔ s₁ = true) ∧
        ((r₁ - 1, c₁) ∈ cells ↔ s₁ = false)) ∨
      (r₂ = r₁ ∧ c₂ = c₁ + 1 ∧
        ((r₁ - 1, c₁) ∈ cells ↔ s₁ = true) ∧
        ((r₁, c₁) ∈ cells ↔ s₁ = false)) ∨
      (r₂ = r₁ ∧ c₂ = c₁ - 1 ∧
        ((r₁, c₁ - 1) ∈ cells ↔ s₁ = true) ∧
        ((r₁ - 1, c₁ - 1) ∈ cells ↔ s₁ = false)))
    (hnoReturn : (r₀, c₀) ≠ (r₂, c₂))
    (hdiag₁ : ¬ ((r₁ - 1, c₁ - 1) ∈ cells ∧ (r₁ - 1, c₁) ∉ cells ∧
      (r₁, c₁) ∈ cells ∧ (r₁, c₁ - 1) ∉ cells))
    (hdiag₂ : ¬ ((r₁ - 1, c₁ - 1) ∉ cells ∧ (r₁ - 1, c₁) ∈ cells ∧
      (r₁, c₁) ∉ cells ∧ (r₁, c₁ - 1) ∈ cells)) :
    s₀ = s₁ := by
  have hin : ∃ d : Fin 4,
      (incomingLeftCell r₁ c₁ d ∈ cells ↔ s₀ = true) ∧
      (incomingRightCell r₁ c₁ d ∈ cells ↔ s₀ = false) ∧
      (d.val = 0 → r₁ = r₀ ∧ c₁ = c₀ + 1) ∧
      (d.val = 1 → r₁ = r₀ + 1 ∧ c₁ = c₀) ∧
      (d.val = 2 → r₁ = r₀ ∧ c₁ = c₀ - 1) ∧
      (d.val = 3 → r₁ = r₀ - 1 ∧ c₁ = c₀) := by
    rcases hfirst with h | h | h | h
    · refine ⟨1, ?_⟩
      simp only [incomingLeftCell, incomingRightCell, Fin.val_one]
      simp_all
    · refine ⟨3, ?_⟩
      simp only [incomingLeftCell, incomingRightCell]
      simp_all
    · refine ⟨0, ?_⟩
      simp only [incomingLeftCell, incomingRightCell]
      simp_all
    · refine ⟨2, ?_⟩
      simp only [incomingLeftCell, incomingRightCell]
      simp_all
  have hout : ∃ d : Fin 4,
      (outgoingLeftCell r₁ c₁ d ∈ cells ↔ s₁ = true) ∧
      (outgoingRightCell r₁ c₁ d ∈ cells ↔ s₁ = false) ∧
      (d.val = 0 → r₂ = r₁ ∧ c₂ = c₁ + 1) ∧
      (d.val = 1 → r₂ = r₁ + 1 ∧ c₂ = c₁) ∧
      (d.val = 2 → r₂ = r₁ ∧ c₂ = c₁ - 1) ∧
      (d.val = 3 → r₂ = r₁ - 1 ∧ c₂ = c₁) := by
    rcases hsecond with h | h | h | h
    · refine ⟨1, ?_⟩
      simp only [outgoingLeftCell, outgoingRightCell, Fin.val_one]
      simp_all
    · refine ⟨3, ?_⟩
      simp only [outgoingLeftCell, outgoingRightCell]
      simp_all
    · refine ⟨0, ?_⟩
      simp only [outgoingLeftCell, outgoingRightCell]
      simp_all
    · refine ⟨2, ?_⟩
      simp only [outgoingLeftCell, outgoingRightCell]
      simp_all
  obtain ⟨din, hlin, hrin, hdin⟩ := hin
  obtain ⟨dout, hlout, hrout, hdout⟩ := hout
  apply boundaryVertex_consecutive_sides_eq cells r₁ c₁ din dout s₀ s₁
    hdiag₁ hdiag₂ ⟨hlin, hrin⟩ ⟨hlout, hrout⟩
  intro heq
  have hneq : r₀ ≠ r₂ ∨ c₀ ≠ c₂ := by
    by_contra h
    push Not at h
    exact hnoReturn (Prod.ext h.1 h.2)
  rcases hdin with ⟨hd0, hd1, hd2, hd3⟩
  rcases hdout with ⟨ho0, ho1, ho2, ho3⟩
  fin_cases din <;> fin_cases dout <;>
    simp [cellBoundaryIncomingEdge, cellBoundaryOutgoingEdge,
      ZMod.val_one_eq_one_mod, ZMod.val_ofNat] at heq hd0 hd1 hd2 hd3 ho0 ho1 ho2 ho3 <;>
    omega

/-- At each pair of successive steps away from the period seam, the actual
simple closed walk keeps its interior cells on the same side. -/
theorem vertexSimpleWalk_consecutive_interior_sides_eq
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : Fin m) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    ∀ s₀ s₁ : Bool,
      ((row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
          ((row j.val, col j.val) ∈ cells ↔ s₀ = true) ∧
          ((row j.val, col j.val - 1) ∈ cells ↔ s₀ = false)) ∨
        (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
          ((row j.val - 1, col j.val - 1) ∈ cells ↔ s₀ = true) ∧
          ((row j.val - 1, col j.val) ∈ cells ↔ s₀ = false)) ∨
        (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
          ((row j.val - 1, col j.val) ∈ cells ↔ s₀ = true) ∧
          ((row j.val, col j.val) ∈ cells ↔ s₀ = false)) ∨
        (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
          ((row j.val, col j.val - 1) ∈ cells ↔ s₀ = true) ∧
          ((row j.val - 1, col j.val - 1) ∈ cells ↔ s₀ = false))) →
      ((row (j.val + 2) = row (j.val + 1) + 1 ∧
          col (j.val + 2) = col (j.val + 1) ∧
          ((row (j.val + 1), col (j.val + 1)) ∈ cells ↔ s₁ = true) ∧
          ((row (j.val + 1), col (j.val + 1) - 1) ∈ cells ↔ s₁ = false)) ∨
        (row (j.val + 2) = row (j.val + 1) - 1 ∧
          col (j.val + 2) = col (j.val + 1) ∧
          ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ↔ s₁ = true) ∧
          ((row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ↔ s₁ = false)) ∨
        (row (j.val + 2) = row (j.val + 1) ∧
          col (j.val + 2) = col (j.val + 1) + 1 ∧
          ((row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ↔ s₁ = true) ∧
          ((row (j.val + 1), col (j.val + 1)) ∈ cells ↔ s₁ = false)) ∨
        (row (j.val + 2) = row (j.val + 1) ∧
          col (j.val + 2) = col (j.val + 1) - 1 ∧
          ((row (j.val + 1), col (j.val + 1) - 1) ∈ cells ↔ s₁ = true) ∧
          ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ↔ s₁ = false))) →
      s₀ = s₁ := by
  dsimp only
  intro s₀ s₁ hfirst hsecond
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  have hnoReturn : (row j.val, col j.val) ≠
      (row (j.val + 2), col (j.val + 2)) := by
    intro heq
    have h := walkSideInteriorBandFromWalk_no_two_step_return γ hγ j
    apply h
    have hleft : Fin.ofNat (m + 2) j.val = Fin.castSucc (Fin.castSucc j) := by
      apply Fin.ext
      simp [Fin.ofNat, Nat.mod_eq_of_lt (by omega : j.val < m + 2)]
    have hright : Fin.ofNat (m + 2) (j.val + 2) = Fin.succ (Fin.succ j) := by
      apply Fin.ext
      simp [Fin.ofNat, Nat.mod_eq_of_lt (by omega : j.val + 2 < m + 2)]
    dsimp [row, col] at heq
    have hp : planeLift γ (Fin.ofNat (m + 2) j.val) =
        planeLift γ (Fin.ofNat (m + 2) (j.val + 2)) :=
      Prod.ext (congrArg Prod.fst heq) (congrArg Prod.snd heq)
    rw [hleft, hright] at hp
    exact hp
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk,
      Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct (row (j.val + 1)) (col (j.val + 1))
  rw [← hcell (row (j.val + 1) - 1) (col (j.val + 1) - 1),
    ← hcell (row (j.val + 1) - 1) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1) - 1)] at hdiag
  have hdiag₁ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∉ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  exact gridConsecutiveInteriorSides_eq cells
    (row j.val) (col j.val) (row (j.val + 1)) (col (j.val + 1))
    (row (j.val + 2)) (col (j.val + 2)) s₀ s₁
    hfirst hsecond hnoReturn hdiag₁ hdiag₂

/-- The interior sides supplied by the actual step theorem agree for two
successive steps of the walk. -/
theorem vertexSimpleWalk_adjacent_interior_side_eq
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : Fin m) :
    Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val (by omega)) =
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct
          (j.val + 1) (by omega)) := by
  classical
  let hfirst := vertexSimpleWalk_step_interior_side
    γ hγ hh hv hdistinct j.val (by omega)
  let hsecond := vertexSimpleWalk_step_interior_side
    γ hγ hh hv hdistinct (j.val + 1) (by omega)
  exact vertexSimpleWalk_consecutive_interior_sides_eq
    γ hγ hh hv hdistinct j
    (Classical.choose hfirst) (Classical.choose hsecond)
    (Classical.choose_spec hfirst) (Classical.choose_spec hsecond)

end Ising2DLambda.KacWard
