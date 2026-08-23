/- 必要十分版を正の有理数の一般の乗根列へ特殊化する。 -/
import Ising3DCut.LimitQuantity.CollisionFreeCoarseGrainingSufficientOnGeneralFamilies
import Ising3DCut.NecSuf.CollisionFreeCoarseGrainingSufficientOnGeneralFamilies

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版の写像としての一致を必要十分版から取り出す。 -/
theorem collision_free_coarse_graining_gives_equal_root_sequences_viaNecSuf
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ) (hagree : ∀ L, π (A L) = π (B L)) :
    (fun L => posRoot ((A L : ℝ)) (M L)) = fun L => posRoot ((B L : ℝ)) (M L) := by
  exact Ising3DCut.NecSuf.collision_free_map_gives_equal_observed_sequences
    π (fun (L : ℕ) (v : ℚ) => posRoot (v : ℝ) (M L)) (fun v : ℚ => 0 < v)
    hfree A B hA hB hagree

/-- 具体版の収束移送を必要十分版から取り出す。 -/
theorem collision_free_coarse_graining_is_sufficient_on_general_families_viaNecSuf
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ) (hagree : ∀ L, π (A L) = π (B L))
    (α : ℝ) (hlimit : Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 α)) :
    Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 α) := by
  exact Ising3DCut.NecSuf.collision_free_map_is_sufficient_on_general_families
    π (fun (L : ℕ) (v : ℚ) => posRoot (v : ℝ) (M L)) (fun v : ℚ => 0 < v)
    hfree A B hA hB hagree α hlimit

/-- 具体版の極限値の一致を必要十分版から取り出す。 -/
theorem collision_free_coarse_graining_limits_agree_on_general_families_viaNecSuf
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ) (hagree : ∀ L, π (A L) = π (B L))
    (α β : ℝ)
    (hlimit : Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 α))
    (hlimit' : Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 β)) :
    α = β := by
  exact Ising3DCut.NecSuf.collision_free_map_limits_agree_on_general_families
    π (fun (L : ℕ) (v : ℚ) => posRoot (v : ℝ) (M L)) (fun v : ℚ => 0 < v)
    hfree A B hA hB hagree α β hlimit hlimit'

end Ising3DCut.LimitQuantity
