/-
「値の衝突を持たない粗視化は、定数列に限らない一般の族に対しても箱サイズ極限に十分である」の
Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち任意の添字 `L` について
粗視化の値が一致する段、衝突が無いことから元の値 `A L = B L` を得る段、
`a L` の定義の段、同じ次数 `M L` の正の乗根を取る段、`b L` の定義から `a L = b L` を得る段、
そして `a` の箱サイズ極限が存在すれば `b` の箱サイズ極限も存在して一致する段を、この順で辿る。
-/
import Ising3DCut.LimitQuantity.CollidingCoarseGrainingNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 値の衝突を持たない粗視化については、一般の族（定数列とは限らない）の上でも、
粗視化の値がすべての添字で一致すれば二つの乗根列は写像として等しい。 -/
theorem collision_free_coarse_graining_gives_equal_root_sequences
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ)
    (hagree : ∀ L, π (A L) = π (B L)) :
    (fun L => posRoot ((A L : ℝ)) (M L)) = fun L => posRoot ((B L : ℝ)) (M L) := by
  funext L
  -- 人手証明の「任意の `L` について粗視化の値が一致する」の段。
  have hpi : π (A L) = π (B L) := hagree L
  -- 人手証明の「衝突が無いので元の値が一致する」の段。
  have hval : A L = B L := hfree (A L) (B L) (hA L) (hB L) hpi
  -- 人手証明の「同じ次数 `M L` の正の乗根を取る」の段。
  rw [hval]

/-- 上の写像としての一致から、`a` の箱サイズ極限が存在すれば `b` の箱サイズ極限も存在し、
両者は一致する。 -/
theorem collision_free_coarse_graining_is_sufficient_on_general_families
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ)
    (hagree : ∀ L, π (A L) = π (B L))
    (α : ℝ) (hlimit : Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 α)) :
    Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 α) := by
  -- 人手証明の「二つの列は写像として等しい」の段。
  have heq := collision_free_coarse_graining_gives_equal_root_sequences π hfree A B hA hB M hagree
  -- 人手証明の「収束の定義に現れるのは列の値だけなので同じ値へ収束する」の段。
  rwa [heq] at hlimit

/-- 実数列の極限は一意なので、`b` の箱サイズ極限として与えられた値は `a` の箱サイズ極限に等しい。 -/
theorem collision_free_coarse_graining_limits_agree_on_general_families
    {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (A B : ℕ → ℚ) (hA : ∀ L, (0 : ℚ) < A L) (hB : ∀ L, (0 : ℚ) < B L)
    (M : ℕ → ℕ)
    (hagree : ∀ L, π (A L) = π (B L))
    (α β : ℝ)
    (hlimit : Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 α))
    (hlimit' : Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 β)) :
    α = β := by
  have hB' := collision_free_coarse_graining_is_sufficient_on_general_families
    π hfree A B hA hB M hagree α hlimit
  exact tendsto_nhds_unique hB' hlimit'

end Ising3DCut.LimitQuantity
