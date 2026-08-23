/- 必要十分版を正の有理数の定数乗根列へ特殊化する。 -/
import Ising3DCut.LimitQuantity.CollisionFreeCoarseGrainingSufficientOnConstantSequences
import Ising3DCut.NecSuf.CollisionFreeCoarseGrainingSufficientOnConstantSequences

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版と同じ形の結論を必要十分版から取り出す。 -/
theorem collision_free_coarse_graining_is_sufficient_on_constant_sequences_viaNecSuf
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (u w : ℚ) (hu : (0 : ℚ) < u) (hw : (0 : ℚ) < w)
    (A B : ℕ → ℚ) (M : ℕ → ℕ)
    (hA : ∀ L, A L = u) (hB : ∀ L, B L = w) (hM : ∀ L, M L = 1)
    (hagree : ∀ L, π (A L) = π (B L)) :
    ∃ ℓ : ℝ,
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ) := by
  obtain ⟨ℓ, hAlim, hBlim⟩ :=
    Ising3DCut.NecSuf.collision_free_map_is_sufficient_on_constant_sequences
      π (fun v : ℚ => (v : ℝ)) (fun v : ℚ => 0 < v) hfree u w hu hw A B hA hB hagree
  refine ⟨ℓ, ?_, ?_⟩
  · have heq : (fun L => posRoot ((A L : ℝ)) (M L)) = fun L => ((A L : ℚ) : ℝ) := by
      funext L
      rw [hA L, hM L]
      exact congrFun (posRoot_one_const u hu) L
    rw [heq]
    exact hAlim
  · have heq : (fun L => posRoot ((B L : ℝ)) (M L)) = fun L => ((B L : ℚ) : ℝ) := by
      funext L
      rw [hB L, hM L]
      exact congrFun (posRoot_one_const w hw) L
    rw [heq]
    exact hBlim

end Ising3DCut.LimitQuantity
