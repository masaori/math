/-
「非負の元の有理数倍は係数の大小で比較できる」の必要十分版。

具体版が使うのは次だけである。係数の住処 `K` について、`r ≤ s` から `0 ≤ s − r` が出ること
（順序付き加法群。`sub_nonneg`）と `(s − r) + r = s`（加法群）、元の住処 `X` について
作用が零を零へ送り（`smul_zero`）、係数の加法に分配し（`add_smul`）、零が加法の単位元であること
（`zero_add`）、そして関係 `le` について
(1) 非負係数の作用が `le` を保つこと（`claim_rational_log_order_group_nonneg_scalar_monotone`）、
(2) 右から同じ元を足しても `le` が保たれること（`claim_rational_log_order_group_add_monotone`）。
`le` の推移律・反射律・反対称性、`Λ_ℚ` や共通分母の中身は使わない。
`K` を体にする必要も、`X` の順序が `le` 以外の性質を持つ必要もない。
`[Ring K]`・`[Module K X]` は `add_smul`・`smul_zero` を得るための最小限で、
順序は `K` の加法群についてだけ要る（`[IsOrderedAddMonoid K]` で `sub_nonneg` が出る）。
-/
import Mathlib.Algebra.Order.Group.Defs
import Mathlib.Algebra.Module.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {K X : Type*} [Ring K] [PartialOrder K] [IsOrderedAddMonoid K]
  [AddCommGroup X] [Module K X]

/-- 非負の元 `ν`（`le 0 ν`）について、係数 `r ≤ s` から `le (r • ν) (s • ν)`。 -/
theorem smul_le_smul_of_le_of_nonneg_necSuf (le : X → X → Prop)
    (hsmul : ∀ (c : K), 0 ≤ c → ∀ x y : X, le x y → le (c • x) (c • y))
    (hadd : ∀ x y z : X, le x y → le (x + z) (y + z))
    {r s : K} (hrs : r ≤ s) {ν : X} (hν : le 0 ν) :
    le (r • ν) (s • ν) := by
  -- c := s − r、0 ≤ c
  have hc : 0 ≤ s - r := sub_nonneg.mpr hrs
  -- (1): c·0 ≤ c·ν、そして c·0 = 0
  have h1 : le ((s - r) • (0 : X)) ((s - r) • ν) := hsmul (s - r) hc 0 ν hν
  rw [smul_zero] at h1
  -- (2): 0 + r·ν ≤ c·ν + r·ν
  have h2 := hadd 0 ((s - r) • ν) (r • ν) h1
  -- 鎖: r·ν = 0 + r·ν ≤ c·ν + r·ν = (c+r)·ν = s·ν
  rw [zero_add, ← add_smul, sub_add_cancel] at h2
  exact h2

end Ising2DLambda.NecSuf.ThermodynamicLimit
