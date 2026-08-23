/-
「定数列の族に限れば、値の衝突を持たない粗視化は箱サイズ極限に十分である」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち定数列の族 `A L = u`, `B L = w`, `M L = 1` について、
添字 `1` の一点で `π u = π w` を得る段、衝突が無いことから `u = w` を得る段、
`M L = 1` なので二つの乗根列がそれぞれ定数列 `u`, `w` に等しい段、
そして両者の箱サイズ極限がともに存在して一致する段を、この順で辿る。
-/
import Ising3DCut.LimitQuantity.CollidingCoarseGrainingNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 値の衝突を持たない粗視化については、定数列の族の上で粗視化の値がすべての添字で
一致すれば、二つの乗根列の箱サイズ極限はともに存在して一致する。 -/
theorem collision_free_coarse_graining_is_sufficient_on_constant_sequences
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (u w : ℚ) (hu : (0 : ℚ) < u) (hw : (0 : ℚ) < w)
    (A B : ℕ → ℚ) (M : ℕ → ℕ)
    (hA : ∀ L, A L = u) (hB : ∀ L, B L = w) (hM : ∀ L, M L = 1)
    (hagree : ∀ L, π (A L) = π (B L)) :
    ∃ ℓ : ℝ,
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ) := by
  -- 人手証明の「添字 `1` の一点で粗視化の値が一致する」の段。
  have hpi : π u = π w := by
    have := hagree 1
    rwa [hA 1, hB 1] at this
  -- 人手証明の「衝突が無いので元の値が一致する」の段。
  have huw : u = w := hfree u w hu hw hpi
  refine ⟨((u : ℝ)), ?_, ?_⟩
  · -- 人手証明の「`a` は定数列 `u` なので箱サイズ極限は `u`」の段。
    have : (fun L => posRoot ((A L : ℝ)) (M L)) = fun _ : ℕ => ((u : ℝ)) := by
      funext L
      rw [hA L, hM L]
      exact congrFun (posRoot_one_const u hu) L
    rw [this]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は定数列 `w = u` なので箱サイズ極限も同じ値である」の段。
    have : (fun L => posRoot ((B L : ℝ)) (M L)) = fun _ : ℕ => ((u : ℝ)) := by
      funext L
      rw [hB L, hM L, ← huw]
      exact congrFun (posRoot_one_const u hu) L
    rw [this]
    exact tendsto_const_nhds

end Ising3DCut.LimitQuantity
