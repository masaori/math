import Ising2DLambda.KacWard.CellCornerConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

theorem gridEdgeEndpoints_injective : Function.Injective gridEdgeEndpoints := by
  intro e f h
  rcases e with ⟨b, r, c⟩
  rcases f with ⟨b', s, d⟩
  cases b <;> cases b'
  · have h₁ : (r, c) ∈ gridEdgeEndpoints (false, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    have h₂ : (r, c + 1) ∈ gridEdgeEndpoints (false, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    simp [gridEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all <;> omega
  · have h₁ : (r, c) ∈ gridEdgeEndpoints (true, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    have h₂ : (r, c + 1) ∈ gridEdgeEndpoints (true, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    simp [gridEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all
  · have h₁ : (r, c) ∈ gridEdgeEndpoints (false, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    have h₂ : (r + 1, c) ∈ gridEdgeEndpoints (false, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    simp [gridEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all
  · have h₁ : (r, c) ∈ gridEdgeEndpoints (true, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    have h₂ : (r + 1, c) ∈ gridEdgeEndpoints (true, (s, d)) := by
      rw [← h]; simp [gridEdgeEndpoints]
    simp [gridEdgeEndpoints] at h₁ h₂
    rcases h₁ with h₁ | h₁ <;> rcases h₂ with h₂ | h₂ <;> simp_all <;> omega

end Ising2DLambda.KacWard
