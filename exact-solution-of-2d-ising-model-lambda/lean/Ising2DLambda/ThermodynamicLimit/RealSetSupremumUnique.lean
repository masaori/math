/-
人手証明「上限の一意性（記法 sup の正当化）」の具体版。

realEscape: 実数の部分集合の上限（最小上界）がただ一つであることを述べるため。
使うのは順序体の性質と略記 ≤_ℝ、順序の三分律、上界・上限の定義だけであり、完備性は使わない。

準備の二つ（u₁ ≤ u₂ と u₂ ≤ u₁。それぞれ相手が上界であることへ最小性を適用する）、
本体の場合分け（≤ の略記の展開。u₁ < u₂ の場合は u₂ ≤ u₁ の展開のどちらも
三分律に反する）を同じ順で辿る。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremumApproximation

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_real_set_supremum_unique`。人手証明の場合分けを辿る。 -/
theorem realSetSupremum_unique
    (S : Set ℝ) (u₁ u₂ : ℝ)
    (h₁ : IsRealSetSupremum S u₁) (h₂ : IsRealSetSupremum S u₂) :
    u₁ = u₂ := by
  -- 準備の第一: u₂ は上界（h₂ の前半）なので、u₁ の最小性より u₁ ≤ u₂。
  have h12 : u₁ ≤ u₂ := h₁.2 u₂ h₂.1
  -- 準備の第二: u₁ と u₂ を入れ替えて同じ議論を行う。
  have h21 : u₂ ≤ u₁ := h₂.2 u₁ h₁.1
  -- 本体: 略記の展開（u₁ < u₂ または u₁ = u₂）。
  rcases lt_or_eq_of_le h12 with hlt | heq
  · -- u₁ < u₂ の場合: u₂ ≤ u₁ の展開のどちらも三分律（ちょうど一つ）に反する。
    exfalso
    rcases lt_or_eq_of_le h21 with hlt' | heq'
    · -- u₂ < u₁ は u₁ < u₂ と両立しない。
      exact lt_asymm hlt hlt'
    · -- u₂ = u₁ は u₁ < u₂ と両立しない。
      exact absurd (heq' ▸ hlt) (lt_irrefl u₁)
  · -- u₁ = u₂ の場合: 主張を得る。
    exact heq

end Ising2DLambda.ThermodynamicLimit
