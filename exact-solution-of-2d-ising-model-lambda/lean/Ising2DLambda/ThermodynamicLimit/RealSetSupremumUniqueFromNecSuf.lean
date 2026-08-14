/- 必要十分版を実数へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.RealSetSupremumUnique
import Ising2DLambda.NecSuf.ThermodynamicLimit.RealSetSupremumUnique

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `claim_real_set_supremum_unique` を導く。 -/
theorem realSetSupremum_unique_from_necSuf
    (S : Set ℝ) (u₁ u₂ : ℝ)
    (h₁ : IsRealSetSupremum S u₁) (h₂ : IsRealSetSupremum S u₂) :
    u₁ = u₂ := by
  have h₁' : IsLUB S u₁ := by
    constructor
    · intro y hy
      exact h₁.1 y hy
    · intro M hM
      exact h₁.2 M (fun y hy => hM hy)
  have h₂' : IsLUB S u₂ := by
    constructor
    · intro y hy
      exact h₂.1 y hy
    · intro M hM
      exact h₂.2 M (fun y hy => hM hy)
  exact NecSuf.ThermodynamicLimit.leastUpperBound_unique_necSuf S u₁ u₂ h₁' h₂'

end Ising2DLambda.ThermodynamicLimit
