/-
「破れ数がちょうど 1 の配位は存在しない」の Lean 具体版の前半。
各辺に、その両端を結ぶ別の三辺があるなら、一辺だけが破れることはないと示す。
次の段で三次元箱の各辺について同じ正方形の残り三辺を構成する。

住処: 有限集合と等号だけ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.BrokenComplement

namespace Ising3DCut.NullModel

/-- 一つの辺の両端を別の三辺で結べるなら、その一辺だけを破れ辺にはできない。 -/
theorem brokenCount_ne_one_of_alternate_three_edges {L : ℕ} (σ : Config L)
    (alternate : ∀ e : Edge L, ∃ f₁ f₂ f₃ : Edge L,
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      endpoint0 f₁ = endpoint0 e ∧
      endpoint1 f₁ = endpoint0 f₂ ∧
      endpoint1 f₂ = endpoint0 f₃ ∧
      endpoint1 f₃ = endpoint1 e) :
    brokenCount σ ≠ 1 := by
  intro hone
  have hcard : (brokenSet σ).card = 1 := hone
  obtain ⟨e, hsingleton⟩ := Finset.card_eq_one.mp hcard
  obtain ⟨f₁, f₂, f₃, hf₁e, hf₂e, hf₃e, hstart, h₁₂, h₂₃, hend⟩ := alternate e
  have heBroken : σ (endpoint0 e) ≠ σ (endpoint1 e) := by
    have : e ∈ brokenSet σ := by simp [hsingleton]
    simpa [brokenSet] using this
  have hf₁ : σ (endpoint0 f₁) = σ (endpoint1 f₁) := by
    have : f₁ ∉ brokenSet σ := by simp [hsingleton, hf₁e]
    simpa [brokenSet] using this
  have hf₂ : σ (endpoint0 f₂) = σ (endpoint1 f₂) := by
    have : f₂ ∉ brokenSet σ := by simp [hsingleton, hf₂e]
    simpa [brokenSet] using this
  have hf₃ : σ (endpoint0 f₃) = σ (endpoint1 f₃) := by
    have : f₃ ∉ brokenSet σ := by simp [hsingleton, hf₃e]
    simpa [brokenSet] using this
  apply heBroken
  calc
    σ (endpoint0 e) = σ (endpoint0 f₁) := congrArg σ hstart.symm
    _ = σ (endpoint1 f₁) := hf₁
    _ = σ (endpoint0 f₂) := congrArg σ h₁₂
    _ = σ (endpoint1 f₂) := hf₂
    _ = σ (endpoint0 f₃) := congrArg σ h₂₃
    _ = σ (endpoint1 f₃) := hf₃
    _ = σ (endpoint1 e) := congrArg σ hend

end Ising3DCut.NullModel
