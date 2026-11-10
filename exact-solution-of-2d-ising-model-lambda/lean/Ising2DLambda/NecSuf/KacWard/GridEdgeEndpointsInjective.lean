import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- The endpoint sets determine an axis, a starting point, and a positive step. -/
def coordinateEdgeEndpoints (step : ℤ) : Bool × (ℤ × ℤ) → Finset (ℤ × ℤ)
  | (false, (r, c)) => {(r, c), (r, c + step)}
  | (true, (r, c)) => {(r, c), (r + step, c)}

theorem coordinateEdgeEndpoints_injective (step : ℤ) (hstep : 0 < step) :
    Function.Injective (coordinateEdgeEndpoints step) := by
  intro e f h
  rcases e with ⟨b, r, c⟩
  rcases f with ⟨b', s, d⟩
  cases b <;> cases b'
  · have h₁ : (r, c) ∈ coordinateEdgeEndpoints step (false, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    have h₂ : (r, c + step) ∈ coordinateEdgeEndpoints step (false, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    simp [coordinateEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all <;> omega
  · have h₁ : (r, c) ∈ coordinateEdgeEndpoints step (true, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    have h₂ : (r, c + step) ∈ coordinateEdgeEndpoints step (true, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    simp [coordinateEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all
  · have h₁ : (r, c) ∈ coordinateEdgeEndpoints step (false, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    have h₂ : (r + step, c) ∈ coordinateEdgeEndpoints step (false, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    simp [coordinateEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all
  · have h₁ : (r, c) ∈ coordinateEdgeEndpoints step (true, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    have h₂ : (r + step, c) ∈ coordinateEdgeEndpoints step (true, (s, d)) := by
      rw [← h]; simp [coordinateEdgeEndpoints]
    simp [coordinateEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all <;> omega

end Ising2DLambda.NecSuf.KacWard
